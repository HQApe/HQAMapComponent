//
//  HQViewController.m
//  HQMapComponent
//
//  Created by HQApe on 07/29/2018.
//  Copyright (c) 2018 HQApe. All rights reserved.
//

#import "HQViewController.h"

#import <HQMapComponent/CTMediator+HQMapComponent.h>
@interface HQViewController ()

@end

@implementation HQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)jump:(id)sender {
    
    UIViewController *mapVc = [[CTMediator sharedInstance] fetchMapViewControllerWithLocation:[[CLLocation alloc] initWithLatitude:34 longitude:116.0] ];
    [self.navigationController pushViewController:mapVc animated:YES];
}
- (IBAction)locating:(id)sender {
    [[CTMediator sharedInstance] getCurrentLocationCompletion:^(CLLocation *location) {
        NSLog(@"%@", location);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
