//
//  TRVRootGuideTabController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/10/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVRootGuideTabController.h"

@interface TRVRootGuideTabController ()

@end

@implementation TRVRootGuideTabController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *tabbarVCs = @[[[UIStoryboard storyboardWithName:@"MyTripsStoryboard" bundle:nil] instantiateInitialViewController],
                           [[UIStoryboard storyboardWithName:@"TourGuideFlow" bundle:nil] instantiateInitialViewController],
                           [[UIStoryboard storyboardWithName:@"Profile" bundle:nil] instantiateInitialViewController]];
    
    
    self.viewControllers = tabbarVCs;
    self.selectedIndex = 0;
    
}




@end
