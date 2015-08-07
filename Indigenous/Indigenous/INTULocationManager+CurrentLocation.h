//
//  INTULocationManager+CurrentLocation.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/5/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "INTULocationManager.h"
/**TODO:deleteme
 *  INTULocationManager wraps around CLLocationManager, which has a 'location' property that conveniently remembers the user's/device's most recent location. Unfortunately, INTU' buries this as a private property. My hacky solution is this, to write a category on INTU' to give it a location or two, and have its singleton carry the data across the app as needed. However, this only works by happy accident, I will be writing a workaround very soon.
 */
@interface INTULocationManager (CurrentLocation)

@property (nonatomic, copy) CLLocation *currentLocation;

@end
