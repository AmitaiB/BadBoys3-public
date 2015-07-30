//
//  TRVCoreLocator.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVCoreLocator.h"

@implementation TRVCoreLocator

/**
 *  After a VC secures location authorization, call this method to obtain current location.
 *
 *  @return CLLocation of current location.
 */
-(CLLocation*)YouAreHere {
    CLLocationManager *locationManager = [CLLocationManager new];
    self.currentLocation = [CLLocation new];
    [locationManager startUpdatingLocation];
    if (self.currentLocation) {
        return self.currentLocation;
    }
    NSLog(@"Error retrieving location (TRVCoreLocator.h)");
    return nil;
}

/**
 *  Shuts down as soon as a location is obtained.
 *
 *  @param manager   CLLocation singleton
 *  @param locations Array of CLLocations, at least one, may be more.
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    if (locations) {
        self.currentLocation = locations.firstObject;
        [manager stopUpdatingLocation];
    }
}


@end
