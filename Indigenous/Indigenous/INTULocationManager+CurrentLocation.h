//
//  INTULocationManager+CurrentLocation.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/5/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "INTULocationManager.h"

@interface INTULocationManager (CurrentLocation)

@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocation *aLocation;

@end
