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
#import <Parse/Parse.h>
#import <malloc/malloc.h>

@implementation NSMutableArray (TRVMutableArray_extraMethods)


-(NSMutableArray *) returnDummyAllTripsArrayForGuide:(TRVUser *)guide {

    NSMutableArray *allTripsArray = [[NSMutableArray alloc] init];
    NSMutableArray *tourStopsArray = [[NSMutableArray alloc] init];
    
    
    TRVTourStop *dummyTourStop1 = [[TRVTourStop alloc] initWithCoordinates:CLLocationCoordinate2DMake(10.0, 10.0)];
    dummyTourStop1.image = [UIImage imageNamed:@"madrid.jpg"];
    dummyTourStop1.nameOfPlace = @"Ippudo";
    dummyTourStop1.addressOfEvent = @"65 4th Ave";
    dummyTourStop1.cityOfEvent = @"New York";
    dummyTourStop1.descriptionOfEvent = @"Best Ramen in the city";

    
    
    TRVTourStop *dummyTourStop2 = [[TRVTourStop alloc] initWithCoordinates:CLLocationCoordinate2DMake(10.0, 10.0)];
    dummyTourStop2.image = [UIImage imageNamed:@"london.jpg"];
    dummyTourStop2.nameOfPlace = @"Totto Ramen";
    dummyTourStop2.addressOfEvent = @"248 E 52nd St";
    dummyTourStop2.cityOfEvent = @"New York";
    dummyTourStop2.descriptionOfEvent = @"The 2nd Best Ramen in the city";

    
    //add 4 dummy stops
    [tourStopsArray addObjectsFromArray:@[dummyTourStop1, dummyTourStop2,dummyTourStop2, dummyTourStop1]];
    
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
        TRVTour *dummyTourInThePast = [[TRVTour alloc] initWithGuideUser:guide itineraryForThisTour:pastItinerary categoryForThisTour:[TRVTourCategory returnCategoryWithTitle:@"See"]];
        dummyTourInThePast.tourDeparture = yesterday;


        
    
    //add 4  of these dummy trips into allTrips Array
    [allTripsArray addObjectsFromArray:@[dummyTourInTheFuture,dummyTourInThePast,dummyTourInThePast, dummyTourInTheFuture,dummyTourInTheFuture,dummyTourInTheFuture]];
    

    //COMMENT OUT IF YOU DO NOT WANT TO CREATE DUMMY DATA
 //   [self createParseDummyTour];

   
    
    return allTripsArray;
}


-(void)createParseDummyTour {
    
    PFUser *currentUser = [PFUser currentUser];
    PFObject *theTour = [PFObject objectWithClassName:@"Tour"];
    [theTour setObject:currentUser forKey:@"guideForThisTour"];
    
    PFObject *theItinerary = [PFObject objectWithClassName:@"Itinerary"];
    theTour[@"categoryForThisTour"] = @"Drink";
    theTour[@"tourDeparture"] = [NSDate dateWithTimeIntervalSinceNow:1000];
//    //  theTour[@"tourAverageRating"] = CGFLOAT;
//    
//    
    PFObject *theStop = [PFObject objectWithClassName:@"TourStop"];
    theTour[@"itineraryForThisTour"] = theItinerary;
    theItinerary[@"nameOfTour"] = @"Some name of tour";
    
    UIImage *tourImage = [UIImage imageNamed:@"madrid.jpg"];
    
    
    // converts tour image to 1/5 quality
    NSData *imageData = UIImageJPEGRepresentation(tourImage, .2f);
    PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
    
    theItinerary[@"tourImage"] = PFImage;
    
//    theItinerary[@"tourImage"] = tourImage;
    theItinerary[@"numberOfStops"] = @1;
    theItinerary[@"tourStops"] = @[theStop];
//
////    // theItinerary[@"attractions"] = ARRAY OF ATTRACTIONS;
//
    theStop[@"operatorCost"] = @0;
    theStop[@"incidentalCost"] = @0;
    theStop[@"lat"] = @10;
    theStop[@"lng"] = @10;
    theStop[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    theStop[@"nameOfPlace"] = @"The Flatiron School";
    theStop[@"descriptionOfEvent"] = @"We will be running through the six with our woes.  You know how that goes.";
    theStop[@"addressOfEvent"] = @"123 Nobody St.";
    
    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
    theStop[@"image"] = PFImage;
    
////    //  theStop[@"tourStopLocation"] = pfgeopoint;
////    
////    //    PFObject *theMarker = [PFObject objectWithClassName:@"GMSMarker"];
////    //    theMarker[@"position"] = PFGEOPOINT;
////    //    theMarker[@"snippet"] = NSSTring;
////    //    theMarker[@"icon"] = UIImage;
////    //    theMarker[@"groundAnchor"] = cgpoint;
////    //    theMarker[@"infoWindowAnchor"] = cgpoint;
////    //
////    //    theStop[@"tourStopMarker"] = theMarker;
////    //
////    

    [theTour saveInBackgroundWithBlock:^(BOOL success, NSError *error){
        NSLog(@"THE TOUR ID IS: %@", theTour.objectId);
       
        
        [currentUser addObject:theTour forKey:@"myTrips"];
        [currentUser saveInBackgroundWithBlock:^(BOOL success, NSError *error){
            if (error){
                NSLog(@"Cant save to array because: %@", error);
            } else {
                NSLog(@"Successfully added stuff to array.");
            }
        }];

        
    }];
    
}


@end
