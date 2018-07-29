//
//  HQAddressModel.h
//  HQAMapLib
//
//  Created by Ape on 2018/7/11.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface HQAddressModel : NSObject

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property(copy, nonatomic) NSString *country;
@property(copy, nonatomic) NSString *province;
@property(copy, nonatomic) NSString *city;
@property(copy, nonatomic) NSString *subcity;
@property(copy, nonatomic) NSString *locality;
@property(copy, nonatomic) NSString *street;

@end
