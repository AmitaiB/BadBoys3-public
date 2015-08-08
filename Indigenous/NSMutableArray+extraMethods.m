//
//  NSMutableArray+TRVMutableArray_extraMethods.m
//  Indigenous
//
//  Created by Leo Kwan on 8/8/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSMutableArray+extraMethods.h"
#import "TRVTour.h"
#import "TRVTourStop.h"
#import "TRVItinerary.h"

@implementation NSMutableArray (TRVMutableArray_extraMethods)

-(NSMutableArray *) returnDummyAllTripsArrayForGuide:(TRVUser *)guide {

    NSMutableArray *allTripsArray = [[NSMutableArray alloc] init];
    NSMutableArray *tourStopsArray = [[NSMutableArray alloc] init];
    
    
    TRVTourStop *dummyTourStop = [[TRVTourStop alloc] initWithCoordinates:CLLocationCoordinate2DMake(10.0, 10.0)];
    
    //add 3 dummy stops
    [tourStopsArray addObjectsFromArray:@[dummyTourStop, dummyTourStop,dummyTourStop]];
    
    //add array to itinerary
    TRVItinerary *dummyItinerary = [[TRVItinerary alloc] initNameOfTour:@"Cool Tour" tourImage:[UIImage imageNamed:@"madrid"] tourStops:tourStopsArray];
    
    // create tour and add itinerary
    TRVTour *dummyTour = [[TRVTour alloc] initWithGuideUser:guide itineraryForThisTour:dummyItinerary];
    
    // make tour far in the future
    dummyTour.tourDeparture = [NSDate dateWithTimeIntervalSinceNow:1000];
        
    
    //add three of these dummy trips into allTrips Array
    [allTripsArray addObjectsFromArray:@[dummyTour,dummyTour,dummyTour]];
    
    return allTripsArray;
}



@end
