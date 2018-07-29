//
//  Action_HQMap.m
//  CTMediator
//
//  Created by Ape on 2018/7/29.
//

#import "Target_HQMap.h"
#import "HQMapViewController.h"
#import <MapKit/MapKit.h>
@implementation Target_HQMap
- (UIViewController *)Action_fetchMapViewController:(NSDictionary *)params {
    HQMapViewController *mapVc = [[HQMapViewController alloc] init];
    CLLocation *location = params[@"location"];
    if (location) {
        [mapVc addAnnotationToMapViewWithlatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    }
    return mapVc;
}
@end
