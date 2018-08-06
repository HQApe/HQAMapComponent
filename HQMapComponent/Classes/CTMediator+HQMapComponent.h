//
//  CTMediator+HQMapComponent.h
//  CTMediator
//
//  Created by Ape on 2018/7/29.
//

#import <CTMediator/CTMediator.h>
#import <MapKit/MapKit.h>
@interface CTMediator (HQMapComponent)

- (UIViewController *)fetchMapViewController;

- (UIViewController *)fetchMapViewControllerWithLocation:(CLLocation *)location;

- (void)getCurrentLocationCompletion:(void(^)(CLLocation *location))completion;

- (void)registerGDApiKey:(NSString *)apiKey;
@end
