//
//  TRVAddNewStopToItineraryVC.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVAddToursVC.h"
#import "TRVPickerMapViewController.h"
#import "TRVTour.h"
#import "TRVItinerary.h"
#import "TRVTourStop.h"
#import <Parse.h>

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVAddToursVC () <TRVPickerMapDelegate>

@end

@implementation TRVAddToursVC


- (void)viewDidLoad {
    [super viewDidLoad];    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TRVPickerMapViewController *destinationVC = segue.destinationViewController;
    destinationVC.delegate = self;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

//- (void)initializeNewTourConstruct {
//    PFObject *itineraryUnderConstruction = [PFObject objectWithClassName:@"TourUnderConstruction"];
//        //TODO:AMITAI store the growing itinerary in a PFObject to the local datastore
//}

/**
 *  Make sure that a PFObject[@"TourUnderConstruction"][@"ItineraryUnderConstruction"] exists, and save it to @"AddTourPins"...
 */
- (void)userSelectedTourStopLocation:(CLLocation*)location
{
    DBLG
    BOOL didBadBoys3SolveThePFObjectBug = YES;
    if (didBadBoys3SolveThePFObjectBug) {
    
        PFQuery *tourQuery = [PFQuery queryWithClassName:@"ItineraryUnderConstruction"];
                            [tourQuery whereKeyExists:@"Itinerary"];
                            [tourQuery fromPinWithName:@"AddTourVC_Pins"];
        TRVItinerary * itineraryUnderConstruction_TRV;
        PFObject     * itineraryUnderConstruction_PF;
        NSError *queryError = nil;
        NSArray *itineraryObjects = [tourQuery findObjects:&queryError];
        NSLog(@"NSArray <PFObjects> itineraryObjects: %@", [itineraryObjects description]);
        if (queryError) { //If PFObjectWithClassName: @"ItineraryUnderConstruction" does not exist...
                //...then set our itinerary pointers to new objects....
            itineraryUnderConstruction_PF = [PFObject objectWithClassName:@"ItineraryUnderConstruction"];
            itineraryUnderConstruction_TRV = [TRVItinerary new];
            [itineraryUnderConstruction_PF addObject:itineraryUnderConstruction_TRV forKey:@"Itinerary"];
        } else {
                //...if an itinerary object(s) already exist, then our pointers should let us build on them.
            itineraryUnderConstruction_PF = [tourQuery getFirstObject];
            itineraryUnderConstruction_TRV = (TRVItinerary*)itineraryUnderConstruction_PF[@"Itinerary"];
        }
            //Either way, we now have a/our TRVItinerary...
        TRVTourStop *newStop = [[TRVTourStop alloc] initWithCoordinates:location.coordinate];
        [itineraryUnderConstruction_TRV.tourStops addObject:newStop];
        itineraryUnderConstruction_PF[@"Itinerary"] = itineraryUnderConstruction_TRV;
        NSLog(@"The itinerary under construction now has %lu tour stops", itineraryUnderConstruction_TRV.tourStops.count);
        [itineraryUnderConstruction_PF pinWithName:@"AddTourVC_Pins"];
    } else {
        DBLG
        NSLog(@"Need to solve the bug (Invalid write to JSON(TVRItinerary))\nOh, and CLLocation is %@:", [location description]);
    }
}

@end
