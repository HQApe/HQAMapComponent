//
//  Action_HQMap.h
//  CTMediator
//
//  Created by Ape on 2018/7/29.
//

#import <Foundation/Foundation.h>

@interface Target_HQMap : NSObject

- (UIViewController *)Action_fetchMapViewController:(NSDictionary *)params;

- (void)Action_getCurrentLocation:(NSDictionary *)params;

@end
