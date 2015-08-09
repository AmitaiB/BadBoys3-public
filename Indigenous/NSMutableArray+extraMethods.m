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
#import "TRVTourCategory.h"
#import "TRVItinerary.h"

@implementation NSMutableArray (TRVMutableArray_extraMethods)


-(NSMutableArray *) returnDummyAllTripsArrayForGuide:(TRVUser *)guide {

    NSMutableArray *allTripsArray = [[NSMutableArray alloc] init];
    NSMutableArray *tourStopsArray = [[NSMutableArray alloc] init];
    
    
    TRVTourStop *dummyTourStop = [[TRVTourStop alloc] initWithCoordinates:CLLocationCoordinate2DMake(10.0, 10.0)];

    
    
    //add 3 dummy stops
    [tourStopsArray addObjectsFromArray:@[dummyTourStop, dummyTourStop,dummyTourStop]];
    
    //add array to itinerary
    TRVItinerary *futureItinerary = [[TRVItinerary alloc] initNameOfTour:@"Future Tour" tourImage:[UIImage imageNamed:@"madrid"] tourStops:tourStopsArray];
    TRVItinerary *pastItinerary = [[TRVItinerary alloc] initNameOfTour:@"Past Tour" tourImage:[UIImage imageNamed:@"beijing"] tourStops:tourStopsArray];

    // create tour and add itinerary
    

        // make tour far in the future
        TRVTour *dummyTourInTheFuture = [[TRVTour alloc] initWithGuideUser:guide itineraryForThisTour:futureItinerary categoryForThisTour:[TRVTourCategory returnDrinkCategory]];
        dummyTourInTheFuture.tourDeparture = [NSDate dateWithTimeIntervalSinceNow:1000];

        // make tour far in the past
    
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[[NSDate alloc] init]];
    
        [components setHour:-[components hour]];
        [components setMinute:-[components minute]];
        [components setSecond:-[components second]];
        NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
    
        [components setHour:-24];
        [components setMinute:0];
        [components setSecond:0];
        NSDate *yesterday = [cal dateByAddingComponents:components toDate: today options:0];
    
    
        // set these Tours as 1 day old from start
        TRVTour *dummyTourInThePast = [[TRVTour alloc] initWithGuideUser:guide itineraryForThisTour:pastItinerary categoryForThisTour:[TRVTourCategory returnSeeCategory]];
        dummyTourInThePast.tourDeparture = yesterday;

    
    //add 4     of these dummy trips into allTrips Array
    [allTripsArray addObjectsFromArray:@[dummyTourInTheFuture,dummyTourInTheFuture,dummyTourInThePast,dummyTourInThePast, dummyTourInTheFuture]];
    
    return allTripsArray;
}




@end
