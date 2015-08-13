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
#import "CLLocation+Utils.h"
#import "TRVPickerMapViewController.h"
#import <HNKGooglePlacesAutocomplete.h>
#import <AFNetworking.h>


@interface TRVmapKitMap : UIViewController <MKMapViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>

@property (nonatomic, strong) id<TRVPickerMapDelegate> delegate;

@end
