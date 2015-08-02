//
//  TRVTour.h
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVItinerary.h"
#import "TRVUser.h"

@interface TRVTour : NSObject

@property (nonatomic, strong, nonnull) NSArray *clientList;          //A collection of the names of all tour participants.
@property (nonatomic, strong, nonnull) TRVUser *tourGuide;           //The user that created/owns this Tour object.
@property (nonatomic, strong, nonnull) TRVItinerary *tourItinerary;  //A list of a tour's schedule and major travel elements. Maps can be made from this.
@property (nonatomic, strong, nonnull) NSDate *tourDeparture;        //The date of the start of a tour program.
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) CGFloat costing;          //The process of itemizing and calculating all the costs the tour operator will pay on a given tour.
@property (nonatomic) CGFloat incidentals;      //Charges incurred by the participants of a tour, but which are not included in the tour price.
@property (nonatomic, strong) UIImage *image;

/**
 *  For what purpose is the image...? Perhaps it belongs elsewhere.
 */
    //@property (nonatomic, strong) UIImage *image;

@end
