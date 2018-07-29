//
//  HQLocationManager.m
//  HQMapManager
//
//  Created by zhq-t100 on 16/11/3.
//  Copyright © 2016年 Dinpay. All rights reserved.
//

#import "HQLocationManager.h"
#import <AMapSearchKit/AMapSearchAPI.h> //搜索
#import <AMapLocationKit/AMapLocationKit.h>  //定位

@interface HQLocationManager ()<AMapSearchDelegate, AMapLocationManagerDelegate>
{
    HQreGeocodeCompletionBlock _reGeocodeAddressBlock;
    HQPersistenceLocatingCompletionBlock _PersistenceLocationingBlock;
}

@property (strong, nonatomic) AMapLocationManager *locationManager;

@property (strong, nonatomic) AMapSearchAPI *mapSearchAPI;

@end

@implementation HQLocationManager

/**定位工具*/
- (AMapLocationManager *)locationManager
{
    if (_locationManager == nil) {
        //初始化AMapLocationManager对象，设置代理
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //   定位超时时间，最低2s，此处设置为10s
        self.locationManager.locationTimeout =10;
        //   逆地理请求超时时间，最低2s，此处设置为10s
        self.locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}

/**搜索工具*/
- (AMapSearchAPI *)mapSearchAPI
{
    if (_mapSearchAPI == nil) {
        _mapSearchAPI = [[AMapSearchAPI alloc] init];
        _mapSearchAPI.delegate = self;
    }
    return _mapSearchAPI;
}

/**开始持续定位*/
- (void)startPersistenceLocationComplitionBlock:(HQPersistenceLocatingCompletionBlock)complitionBlock
{
    
    CLAuthorizationStatus type = [CLLocationManager authorizationStatus];
    if ([CLLocationManager locationServicesEnabled] && (type == kCLAuthorizationStatusAuthorizedWhenInUse || type == kCLAuthorizationStatusNotDetermined || type == kCLAuthorizationStatusAuthorizedAlways)) {
        
        //定位功能可用，开始定位
        //调用AMapLocationManager提供的startUpdatingLocation方法开启持续定位。
        [self.locationManager startUpdatingLocation];
        _PersistenceLocationingBlock = complitionBlock;
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        complitionBlock(nil, HQLocatingResultUnauthorized);
        
    }
}

/**停止定位*/
- (void)stopPersistenceLocation
{
    [self.locationManager stopUpdatingLocation];
}

/**单次定位*/
- (void)onceTimeFetchUserLocationComplitionBlock:(HQUserLocatingCompletionBlock)complitionBlock
{
    CLAuthorizationStatus type = [CLLocationManager authorizationStatus];
    if ([CLLocationManager locationServicesEnabled] && (type == kCLAuthorizationStatusAuthorizedWhenInUse || type == kCLAuthorizationStatusNotDetermined || type == kCLAuthorizationStatusAuthorizedAlways)) {
        
        // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            if (error) {
                
                complitionBlock(location, nil, HQLocatingResultFailed);
            }else {
                HQAddressModel *address = [[HQAddressModel alloc] init];
                address.country = regeocode.country;
                address.province = regeocode.province;
                address.city = regeocode.city;
                address.subcity = regeocode.district;
                address.street = regeocode.street;
                complitionBlock(location, address, HQLocatingResultSucceed);
            }
        }];
        
        [self stopPersistenceLocation];
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        complitionBlock(nil, nil, HQLocatingResultUnauthorized);
    }
    
}

/**解析指定经纬度 ，只能解析国内的*/
- (void)reGeocodeAddressWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude complitionBlock:(HQreGeocodeCompletionBlock)complitionBlock
{
    CLLocationCoordinate2D coodinate = CLLocationCoordinate2DMake(latitude, longitude);
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coodinate.latitude longitude:coodinate.longitude];
    regeo.requireExtension = YES;
    //发起逆地理编码
    [self.mapSearchAPI AMapReGoecodeSearch:regeo];
    
    _reGeocodeAddressBlock = complitionBlock;
}

/**判断是否在中国大陆*/
- (BOOL)isMainlandChinaLocationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
{
    //设置一个目标经纬度
    CLLocationCoordinate2D coodinate = CLLocationCoordinate2DMake(latitude, longitude);
    //返回是否在大陆或以外地区，返回YES为大陆地区，NO为非大陆。
    return AMapLocationDataAvailableForCoordinate(coodinate);
}

#pragma mark - AMapSearchDelegate
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        HQAddressModel *address = [[HQAddressModel alloc] init];
        address.country = response.regeocode.addressComponent.country;
        address.province = response.regeocode.addressComponent.province;
        address.city = response.regeocode.addressComponent.city;
        address.subcity = response.regeocode.addressComponent.district;
        address.street = response.regeocode.addressComponent.township;
        _reGeocodeAddressBlock(CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude),address, HQLocatingResultSucceed);
    }else {
        _reGeocodeAddressBlock(CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude), nil, HQLocatingResultFailed);
    }
}

#pragma mark - AMapLocationManagerDelegate
/* 连续定位回调 */
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (location) {
        _PersistenceLocationingBlock(location, HQLocatingResultSucceed);
    }else {
        _PersistenceLocationingBlock(nil, HQLocatingResultFailed);
    }
    [self stopPersistenceLocation];
}


@end
