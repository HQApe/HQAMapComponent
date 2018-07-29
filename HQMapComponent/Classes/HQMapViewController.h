//
//  ViewController.h
//  HQMapManager
//
//  Created by zhq-t100 on 16/11/3.
//  Copyright © 2016年 Dinpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HQMapViewController : UIViewController

/**在指定的经纬度上加大头针*/
- (void)addAnnotationToMapViewWithlatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

@end

