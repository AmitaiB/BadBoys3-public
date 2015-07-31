//
//  TRVTouristTripTableViewCell.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTouristTripTableViewCell.h"
#import "TRVTour.h"

@implementation TRVTouristTripTableViewCell

//-(instancetype)initWithTour:(TRVTour*)tour reuseIdentifier:(NSString*)reuseIdentifier {
//    if (self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
//        self.textLabel.text = tour.tourItinerary.name;
//    }
//    return self;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTour:(TRVTour *)tour {
    _tour = tour;
    self.textLabel.text = tour.tourItinerary.name;
}

@end
