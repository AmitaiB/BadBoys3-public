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
    
   
    [self createParseDummyTour];

   
    
    return allTripsArray;
}


-(void)createParseDummyTour {
    
    PFUser *currentUser = [PFUser currentUser];
    PFObject *theTour = [PFObject objectWithClassName:@"Tour"];
    [theTour setObject:currentUser forKey:@"guideForThisTour"];
    
    PFObject *theItinerary = [PFObject objectWithClassName:@"Itinerary"];
    theTour[@"categoryForThisTour"] = @"See";
    
    theTour[@"tourDeparture"] = [NSDate dateWithTimeIntervalSinceNow:10000];
    theTour[@"isPurchased"] = @(YES);
    
    
    PFObject *theStop = [PFObject objectWithClassName:@"TourStop"];
    theTour[@"itineraryForThisTour"] = theItinerary;
    theItinerary[@"nameOfTour"] = @"Some name of tour";
    
    UIImage *tourImage = [UIImage imageNamed:@"beijing.jpg"];
    
    
    // converts tour image to 1/5 quality
    NSData *imageData = UIImageJPEGRepresentation(tourImage, .2f);
    PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
    
    theItinerary[@"tourImage"] = PFImage;


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
    
    NSArray *tourStopsArray = @[theStop, theStop, theStop, theStop];
    theItinerary[@"tourStops"] = tourStopsArray;
    theItinerary[@"numberOfStops"] = @(tourStopsArray.count);

    
    [theTour saveInBackgroundWithBlock:^(BOOL success, NSError *error){
        NSLog(@"THE TOUR ID IS: %@", theTour.objectId);
       
        
        [currentUser addObject:theTour forKey:@"myGuideTrips"];
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
