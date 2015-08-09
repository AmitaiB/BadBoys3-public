//
//  TRVTour.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTour.h"

@interface TRVTour ()

// other properties

@property (nonatomic, strong, nonnull) NSArray *clientList;          //A collection of the names of all tour participants.
@property (nonatomic, strong, nonnull) TRVItinerary *tourItinerary;  //A list of a tour's schedule and major travel elements. Maps can be made from this.
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) CGFloat costing;          //itemizing and calculating all the costs the tour
@property (nonatomic) CGFloat incidentals;      //Charges incurred, but  are not included in the tour price.
@property (nonatomic) BOOL isActive;


@end


@implementation TRVTour


-(instancetype)initWithGuideUser:(TRVUser *)guideUser itineraryForThisTour:(TRVItinerary *)itinerary categoryForThisTour:(TRVTourCategory *)category {

    self = [super init];
    
    if (self) {
        _guideForThisTour = guideUser;
        _itineraryForThisTour = itinerary;
        _categoryForThisTour = category;
        [guideUser.allTrips addObject:self];

    }
    return self;
}



@end
