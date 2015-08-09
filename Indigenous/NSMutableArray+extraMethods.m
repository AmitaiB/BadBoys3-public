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
    
        // make tour far in the future
    
        TRVTour *dummyTourInTheFuture = [[TRVTour alloc] initWithGuideUser:guide itineraryForThisTour:dummyItinerary];
        dummyTourInTheFuture.tourDeparture = [NSDate dateWithTimeIntervalSinceNow:1000];
    
        // make tour far in the past

    	TRVTour *dummyTourInThePast = [[TRVTour alloc] initWithGuideUser:guide itineraryForThisTour:dummyItinerary];
        NSDate *pastDate = [NSDate dateWithTimeIntervalSinceNow:-1000];
        dummyTourInThePast.tourDeparture = pastDate; //[NSDate dateWithTimeIntervalSince1970:1000]; //[NSDate dateWithTimeIntervalSinceNow:-1000];


        
    
    //add 4     of these dummy trips into allTrips Array
    [allTripsArray addObjectsFromArray:@[dummyTourInTheFuture,dummyTourInTheFuture,dummyTourInThePast,dummyTourInThePast]];
    
    return allTripsArray;
}



@end
