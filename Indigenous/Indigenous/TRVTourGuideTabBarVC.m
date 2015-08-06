//
//  TRVTourGuideTabBarVC.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

    //Pre-load current location in the background.
#import <INTULocationManager.h>
#import "INTULocationManager+CurrentLocation.h"

    //model
#import <YALTabBarItem.h>

    //controller (← includes YALFoldingTabBarController.h)
#import "TRVTourGuideTabBarVC.h"

    //helpers
#import <YALAnimatingTabBarConstants.h>

@interface TRVTourGuideTabBarVC () <CLLocationManagerDelegate>

@end

@implementation TRVTourGuideTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        //Preparing leftBarItems...
    YALTabBarItem *item1 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"nearby_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    YALTabBarItem *item2 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"profile_icon"]
                                                      leftItemImage:[UIImage imageNamed:@"edit_icon"]
                                                     rightItemImage:nil];
    self.leftBarItems = @[item1, item2];
    
        //Preparing RightBarItems...
    YALTabBarItem *item3 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"chats_icon"]
                                                      leftItemImage:[UIImage imageNamed:@"search_icon"]
                                                     rightItemImage:[UIImage imageNamed:@"new_chat_icon"]];
    
    YALTabBarItem *item4 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"settings_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    self.rightBarItems = @[item3, item4];
    
    self.centerButtonImage = [UIImage imageNamed:@"plus_icon"];
    
//    self.selectedIndex = 2;

        //customize tabBarView
    self.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
    self.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
    self.tabBarView.backgroundColor = [UIColor colorWithRed:94.0/255.0 green:91.0/255 blue:149.0/255 alpha:1];
    self.tabBarView.tabBarColor = [UIColor colorWithRed:72.0/255 green:211.0/255 blue:178.0/255 alpha:1];
    self.tabBarViewHeight = YALTabBarViewDefaultHeight;
    self.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    self.tabBarView.tabBarItemsEdgeInsets   = YALTabBarViewItemsDefaultEdgeInsets;
    
    
#pragma mark Pre-load current location
    
    INTULocationManager *locationManager = [INTULocationManager sharedInstance];
    
    [locationManager requestLocationWithDesiredAccuracy:INTULocationAccuracyNeighborhood timeout:60 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        NSLog(@"Inside the pre-loading location block. We have %@ succeeded!", (status == INTULocationStatusSuccess) ? @"INDEED" : @"NOT");
        locationManager.currentLocation = currentLocation;
    }];
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    NSLog(@"didUpdateLocations, manager: %@, locations: %@", [manager description], [locations description]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
