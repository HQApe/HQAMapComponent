//
//  Action_HQMap.m
//  CTMediator
//
//  Created by Ape on 2018/7/29.
//

#import "Target_HQMap.h"
#import "HQMapViewController.h"
#import "HQLocationManager.h"
#import <MapKit/MapKit.h>

@interface Target_HQMap ()
@property (strong, nonatomic) HQLocationManager *manager;
@end

@implementation Target_HQMap
- (UIViewController *)Action_fetchMapViewController:(NSDictionary *)params {
    HQMapViewController *mapVc = [[HQMapViewController alloc] init];
    mapVc.location = params[@"location"];
    return mapVc;
}

- (void)Action_getCurrentLocation:(NSDictionary *)params {
    HQLocationManager *manager = [[HQLocationManager alloc] init];
    void (^complitionBlock)(CLLocation *location) = params[@"block"];
    [manager startPersistenceLocationComplitionBlock:^(CLLocation *location, HQLocatingResultType resultType) {
        if (complitionBlock) {
            complitionBlock(location);
        }
    }];
}
@end
