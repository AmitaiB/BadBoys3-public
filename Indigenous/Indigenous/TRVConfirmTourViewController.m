//
//  TRVConfirmTourViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//
#import <Parse.h>
#import "TRVConfirmTourViewController.h"

@interface TRVConfirmTourViewController ()

@end

@implementation TRVConfirmTourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)createParseDummyTourWithName:(NSString*)tourName category:(NSString*)tourCategory date:(NSDate*)departureDate image:(UIImage*)tourImage itinerary:(NSArray*)arrayOfGenericLocations {
//    
//    PFUser *currentUser = [PFUser currentUser];
//    PFObject *theTour = [PFObject objectWithClassName:@"Tour"];
//    [theTour setObject:currentUser forKey:@"guideForThisTour"];
//    
//    PFObject *theItinerary = [PFObject objectWithClassName:@"Itinerary"];
//    theItinerary[@"nameOfTour"] = <#tour name#>
//    theTour[@"categoryForThisTour"] = <#category#>;
//    theTour[@"tourDeparture"] = <#date#>;
//    UIImage *tourImage = <#tour image#>;
//    theTour[@"itineraryForThisTour"] = theItinerary;
//    
//    /**
//     *  From here until ||    theStop[@"image"] = PFImage; || is done for each tourStop.
//     */
//    PFObject *theStop = [PFObject objectWithClassName:@"TourStop"];
//        //!!!These 4 lines are done for each image.
//        // converts tour image to 1/5 quality
//    NSData *imageData = UIImageJPEGRepresentation(tourImage, .2f);
//    PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
//    theItinerary[@"tourImage"] = PFImage;
//    /**
//     *  for later:
//     */
////    theStop[@"operatorCost"] = @0;
////    theStop[@"incidentalCost"] = @0;
////    theStop[@"lat"] = @10;
////    theStop[@"lng"] = @10;
////    theStop[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
//    /**
//     *  important!
//     */
//    theStop[@"nameOfPlace"] = <#place name#>;
//        //TODO give the user a place to add notes to each stop.
//    theStop[@"descriptionOfEvent"] = @"We will be running through the six with our woes.  You know how that goes.";
//    theStop[@"addressOfEvent"] = <# address string#>;
//    
//        // MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
//        // CURRENTLY USING PFIMAGE FROM LINE 18, BUT WE WANT A NEW STOP IMAGE.  REPEAT PROCESS FROM
//        // LINE 15 - 18
//    theStop[@"image"] = PFImage;
//    /**
//     *  ↑↑Tour Stop loop ends here.
//     */
//    
//    /**
//     *  Now we have an array of tourStops, to replace the dummy line below.
//     */
//    
//    NSArray *tourStopsArray = @[theStop, theStop, theStop, theStop];
//    
//    
//    theItinerary[@"tourStops"] = tourStopsArray;
//    theItinerary[@"numberOfStops"] = @(tourStopsArray.count);
//    
//    
//    [theTour saveInBackgroundWithBlock:^(BOOL success, NSError *error){
//        NSLog(@"THE TOUR ID IS: %@", theTour.objectId);
//        
//        [currentUser addObject:theTour forKey:@"myTrips"];
//        [currentUser saveInBackgroundWithBlock:^(BOOL success, NSError *error){
//            if (error){
//                NSLog(@"Cant save to array because: %@", error);
//            } else {
//                NSLog(@"Successfully added stuff to array.");
//            }
//        }];
//        
//        
//    }];
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
