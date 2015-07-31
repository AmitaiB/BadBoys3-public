//
//  TRVTouristTripTableViewCell.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRVTour;

@interface TRVTouristTripTableViewCell : UITableViewCell

@property (nonatomic, strong) TRVTour *tour;

-(instancetype)initWithTour:(TRVTour*)tour reuseIdentifier:(NSString*)reuseIdentifier;

@end
