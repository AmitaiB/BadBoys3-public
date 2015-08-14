//
//  TRVBookTourTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/13/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVBookTourTableViewController.h"
#import "TRVUserDataStore.h"
#import <Parse.h>


@interface TRVBookTourTableViewController ()

@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;

@end

@implementation TRVBookTourTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 4;
}

- (IBAction)goBackButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)bookTourButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"tourBookedSegue" sender:nil];
    
    [self bookTour];
    
    PFUser *currentUser = [PFUser currentUser];
    
//    NSMutableArray *loggedInUserTrips = currentUser[@"myTrips"];
//     NSLog(@"%@" ,self.shared)
    [currentUser addObject:self.destinationPFTour forKey:@"myTrips"];
    [currentUser save];
    
    
    if ([self.destinationTour.categoryForThisTour.categoryName isEqualToString:self.sharedDataStore.currentCategorySearching.categoryName]) {
        
//        
//        [self.sharedDataStore.loggedInUser.PFallTrips addObject:self.destinationPFTour];
//        currentUser[@"myTrips"] setArray:;
        
        

    }

    // LOGIC FOR CREATING A TOUR
    
    
}

//
-(void)bookTour {
//
//    PFUser *currentUser = [PFUser currentUser];
//    
//    PFObject *theTour = [PFObject objectWithClassName:@"Tour"];
////    [theTour setObject:currentUser forKey:@"guideForThisTour"];
//    
//    PFObject *theItinerary = [PFObject objectWithClassName:@"Itinerary"];
//    theTour[@"categoryForThisTour"] = @"See";
//    theTour[@"tourDeparture"] = [NSDate dateWithTimeIntervalSinceNow:1000];
//    theTour[@"isPurchased"] = @(YES);
//    
//    PFObject *theStop = [PFObject objectWithClassName:@"TourStop"];
//    theTour[@"itineraryForThisTour"] = theItinerary;
//    theItinerary[@"nameOfTour"] = @"Some name of tour";
//    
//    UIImage *tourImage = [UIImage imageNamed:@"beijing.jpg"];
//    
//    
//    // converts tour image to 1/5 quality
//    NSData *imageData = UIImageJPEGRepresentation(tourImage, .2f);
//    PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
//    
//    theItinerary[@"tourImage"] = PFImage;
//    
//    
//    theStop[@"operatorCost"] = @0;
//    theStop[@"incidentalCost"] = @0;
//    theStop[@"lat"] = @10;
//    theStop[@"lng"] = @10;
//    theStop[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
//    theStop[@"nameOfPlace"] = @"The Flatiron School";
//    theStop[@"descriptionOfEvent"] = @"We will be running through the six with our woes.  You know how that goes.";
//    theStop[@"addressOfEvent"] = @"123 Nobody St.";
//    
//    //MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
//    theStop[@"image"] = PFImage;
//    
//    NSArray *tourStopsArray = @[theStop, theStop, theStop, theStop];
//    theItinerary[@"tourStops"] = tourStopsArray;
//    theItinerary[@"numberOfStops"] = @(tourStopsArray.count);
//    
//    
//    [theTour saveInBackgroundWithBlock:^(BOOL success, NSError *error){
//        NSLog(@"THE TOUR ID IS: %@", theTour.objectId);
//        
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
}


@end
