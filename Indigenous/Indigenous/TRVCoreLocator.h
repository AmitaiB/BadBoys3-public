//
//  TRVCoreLocator.h
//  Indigenous
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface TRVCoreLocator : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocation *currentLocation;

-(instancetype)init;

-(CLLocation*)YouAreHere;

-(void) safeRequestForWhenInUseAuth;

@end
