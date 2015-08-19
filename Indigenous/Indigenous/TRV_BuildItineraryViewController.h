//
//  TRVBuildItineraryViewController.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRV_TourObject.h"
#import <GoogleMaps/GoogleMaps.h>

@interface TRV_BuildItineraryViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, GMSPanoramaViewDelegate>

@property (strong, nonatomic) TRV_TourObject *tourObject;

@end
