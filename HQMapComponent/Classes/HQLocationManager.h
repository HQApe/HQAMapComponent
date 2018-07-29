//
//  HQLocationManager.h
//  HQMapManager
//
//  Created by zhq-t100 on 16/11/3.
//  Copyright © 2016年 Dinpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "HQAddressModel.h"

typedef NS_ENUM(NSUInteger, HQLocatingResultType) {
    HQLocatingResultFailed,
    HQLocatingResultSucceed,
    HQLocatingResultUnauthorized
};

typedef void (^HQUserLocatingCompletionBlock)(CLLocation *location, HQAddressModel *regeocode, HQLocatingResultType resultType);

typedef void (^HQreGeocodeCompletionBlock)(CLLocationCoordinate2D location, HQAddressModel *regeocode, HQLocatingResultType resultType);

typedef void (^HQPersistenceLocatingCompletionBlock)(CLLocation *location, HQLocatingResultType resultType);


@interface HQLocationManager : NSObject

/**开始持续定位*/
- (void)startPersistenceLocationComplitionBlock:(HQPersistenceLocatingCompletionBlock)complitionBlock;

/**停止定位*/
- (void)stopPersistenceLocation;

/**单次定位*/
- (void)onceTimeFetchUserLocationComplitionBlock:(HQUserLocatingCompletionBlock)complitionBlock;

/**解析指定经纬度 ，只能解析国内的*/
- (void)reGeocodeAddressWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude complitionBlock:(HQreGeocodeCompletionBlock)complitionBlock;

/**判断是否在中国大陆*/
- (BOOL)isMainlandChinaLocationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;


@end
