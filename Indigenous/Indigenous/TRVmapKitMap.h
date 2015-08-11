//
//  TRVmapKitMap.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/11/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <INTULocationManager.h>
#import "TRVPickerMapViewController.h"

@interface TRVmapKitMap : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) id<TRVPickerMapDelegate> delegate;

@end
