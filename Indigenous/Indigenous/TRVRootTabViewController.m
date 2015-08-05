//
//  TRVRootTabViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/1/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVRootTabViewController.h"

@interface TRVRootTabViewController ()

@end

@implementation TRVRootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *tabbarVCs = @[[[UIStoryboard storyboardWithName:@"SearchTrips" bundle:nil] instantiateInitialViewController],
                            [[UIStoryboard storyboardWithName:@"Profile" bundle:nil] instantiateInitialViewController],
                             [[UIStoryboard storyboardWithName:@"MyTripsStoryboard" bundle:nil] instantiateInitialViewController]];

    self.viewControllers = tabbarVCs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
