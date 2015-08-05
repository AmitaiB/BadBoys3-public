//
//  TRVTouristTripDetailViewController.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRVTour;

@interface TRVTouristTripDetailViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) TRVTour *tour;

@end
