//
//  TRVCoreLocator.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVCoreLocator.h"
#import <UIKit/UIKit.h>

@interface TRVCoreLocator()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation TRVCoreLocator


-(instancetype)init {
    self = [super init];
    if (self) {
        _currentLocation = nil;
    }
    return self;
}

/**
 *  After a VC secures location authorization, call this method to obtain current location.
 *
 *  @return CLLocation of current location.
 */
-(CLLocation*)YouAreHere {
    CLLocationManager *locationManager = [CLLocationManager new];
    if ([CLLocationManager locationServicesEnabled]) {
        self.currentLocation = [CLLocation new];
        [locationManager startUpdatingLocation];
    }
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


    //Thanks to Jordan Gugges for finding this snippet online
-(void) safeRequestForWhenInUseAuth {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusDenied ||
        status == kCLAuthorizationStatusRestricted ||
        status == kCLAuthorizationStatusRestricted ||
        status == kCLAuthorizationStatusNotDetermined) {
        
        NSString *title;
        
        title = (status == kCLAuthorizationStatusDenied ||
                 status == kCLAuthorizationStatusRestricted)? @"Location Services Are Off" : @"Background use is not enabled";
        
        NSString *message = @"Go to settings";
        
        UIAlertController *settingsAlert = [UIAlertController alertControllerWithTitle:title
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *goToSettings = [UIAlertAction actionWithTitle:@"Settings"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
        { NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication]openURL:settingsURL];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [settingsAlert addAction:goToSettings];
        [settingsAlert addAction:cancel];
        
        [self presentViewController:settingsAlert animated:YES completion:nil];
        
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}


@end
