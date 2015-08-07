//
//  TRVTourGuideTabBarVC.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

    //Pre-load current location in the background.
#import <INTULocationManager.h>
#import <CoreLocation/CoreLocation.h>
#import "TRVTourGuideTabBarVC.h"

@interface TRVTourGuideTabBarVC () <UITabBarControllerDelegate>

@end

@implementation TRVTourGuideTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
#pragma mark Pre-load current location
//    
//    INTULocationManager *locationManager = [INTULocationManager sharedInstance];
//    
//    [locationManager requestLocationWithDesiredAccuracy:INTULocationAccuracyNeighborhood timeout:10 delayUntilAuthorized:NO block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
//        NSLog(@"Inside the pre-loading location block. We have %@ succeeded!", (status == INTULocationStatusSuccess) ? @"INDEED" : @"NOT");
//        locationManager.currentLocation = currentLocation;
//    }];
//    
    
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
//    NSLog(@"didUpdateLocations, manager: %@, locations: %@", [manager description], [locations description]);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
