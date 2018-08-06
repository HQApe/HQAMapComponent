//
//  CTMediator+HQMapComponent.m
//  CTMediator
//
//  Created by Ape on 2018/7/29.
//

#import "CTMediator+HQMapComponent.h"
#import <MapKit/MapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
NSString * const kCTMediatorHQMap = @"HQMap";
NSString * const kCTMediatorActionFetchMapVC= @"fetchMapViewController";
NSString * const kCTMediatorActionGetCurrentLocation= @"getCurrentLocation";

@implementation CTMediator (HQMapComponent)

- (UIViewController *)fetchMapViewController {
    UIViewController *viewController = [self performTarget:kCTMediatorHQMap action:kCTMediatorActionFetchMapVC params:nil shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return viewController;
    }
    return [[UIViewController alloc] init];
}

- (UIViewController *)fetchMapViewControllerWithLocation:(CLLocation *)location {
    UIViewController *viewController = [self performTarget:kCTMediatorHQMap action:kCTMediatorActionFetchMapVC params:@{@"location":location} shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return viewController;
    }
    return [[UIViewController alloc] init];
}

- (void)getCurrentLocationCompletion:(void (^)(CLLocation *))completion {
    
    [self performTarget:kCTMediatorHQMap action:kCTMediatorActionGetCurrentLocation params:@{@"block":completion} shouldCacheTarget:YES];
}

- (void)registerGDApiKey:(NSString *)apiKey
{
    [[AMapServices sharedServices] setApiKey:apiKey];
}

@end
