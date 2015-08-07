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
//        //TODO: store the growing itinerary in a PFObject to the local datastore
//}

/**
 *  Make sure that a PFObject[@"TourUnderConstruction"][@"ItineraryUnderConstruction"] exists, and save it to @"AddTourPins"...
 */
- (void)userSelectedTourStopLocation:(CLLocation*)location
{
PFQuery *tourQuery = [PFQuery queryWithClassName:@"ItineraryUnderConstruction"];
                        [tourQuery whereKeyExists:@"Itinerary"];
                        [tourQuery fromPinWithName:@"AddTourVC_Pins"];
    if ([tourQuery countObjects] < 1) {
//        [self initializeNewTourConstruct];
        TRVItinerary *itineraryUnderConstruction = 
        = [PFObject objectWithClassName:@"TourUnderConstruction"];
        itineraryUnderConstruction addObject:<#(id __nonnull)#> forKey:<#(NSString * __nonnull)#>
    };
        //TODO:implement the method
}

@end
