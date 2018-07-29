//
//  ViewController.m
//  HQMapManager
//
//  Created by zhq-t100 on 16/11/3.
//  Copyright © 2016年 Dinpay. All rights reserved.
//

#import "HQMapViewController.h"
#import "HQLocationManager.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>  
#import <AMapLocationKit/AMapLocationKit.h>  //实现持续定位

@interface HQMapViewController ()<MAMapViewDelegate, AMapLocationManagerDelegate, AMapSearchDelegate>

@property (strong, nonatomic) HQLocationManager *locationManager;

@property (nonatomic, strong) MAMapView *mapView;

@property (strong, nonatomic) AMapSearchAPI *search;

@end

@implementation HQMapViewController

- (HQLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[HQLocationManager alloc] init];
    }
    return _locationManager;
}

- (MAMapView *)mapView
{
    if (_mapView == nil)
    {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectZero];
        _mapView.showsUserLocation = YES;
        [_mapView setDelegate:self];
    }
    return _mapView;
}

- (AMapSearchAPI *)search
{
    if (_search == nil) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.mapView.frame = self.view.bounds;
    [self.view addSubview:self.mapView];
}

/**在指定的经纬度上加大头针*/
- (void)addAnnotationToMapViewWithlatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
{
    CLLocationCoordinate2D coodinate = CLLocationCoordinate2DMake(latitude, longitude);
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    [annotation setCoordinate:coodinate];
    [self addAnnotationToMapView:annotation];
}

//添加大头针
- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

- (void)cleanUpAction
{
    [self.mapView removeAnnotations:self.mapView.annotations];
}

#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if (![annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout   = YES;
        annotationView.animatesDrop     = YES;
        annotationView.draggable        = NO;
        annotationView.pinColor         = MAPinAnnotationColorPurple;
        
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"%s", __func__);
}

- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
{
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
