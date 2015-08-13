//
//  TRVTouristMyTripsViewController.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSMutableArray+extraMethods.h"

#import "TRVTouristMyTripsViewController.h"
#import "TRVTouristTripDataSource.h"
#import "TRVTouristTripTableViewCell.h"
#import "TRVTouristTripDetailViewController.h"
#import "TRVUserDataStore.h"
#import "TRVUser.h"
#import "TRVTour.h"
#import "TRVTourStop.h"

@interface TRVTouristMyTripsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tripTableView;
@property (nonatomic, strong) TRVTouristTripDataSource *tableViewDataSource;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@end

@implementation TRVTouristMyTripsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"VIEW DID APPEAR %@", self.sharedDataStore.loggedInUser.userBio.firstName);
    
    
    
    
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    [self.sharedDataStore setCurrentUser:[PFUser currentUser] withBlock:^(BOOL success) {
        
        
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {
            PFQuery *query = [PFUser query];
            [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
            
            [query getObjectInBackgroundWithId:[currentUser objectId] block:^(PFObject *user, NSError *error) {
                if (!error) {
                    
                    NSArray *myTrips = user[@"myTrips"];
                    NSLog(@"MY TRIPS ARRAY FROM PARSE: %@", myTrips);
                    
                    self.sharedDataStore.loggedInUser.myTrips = [[NSMutableArray alloc]init];

                    [self completeUser:self.sharedDataStore.loggedInUser bio:self.sharedDataStore.loggedInUser.userBio parseUser:[PFUser currentUser] allTrips:myTrips];
                    
                 //   NSMutableArray *dummyAllTrips = [[NSMutableArray alloc] init];
                 //   NSMutableArray *allTrips = [dummyAllTrips returnDummyAllTripsArrayForGuide:self.sharedDataStore.loggedInUser];
                    
                    self.tableViewDataSource = [[TRVTouristTripDataSource alloc] initWithTrips:self.sharedDataStore.loggedInUser.myTrips configuration:nil];
                    self.tripTableView.dataSource = self.tableViewDataSource;
                    if (self.segmentedControl.selectedSegmentIndex == 1) {
                        [self.tableViewDataSource changeTripsDisplayed];
                        [self.tripTableView reloadData];
                    }


                } else {
                    // show modal
                }
            }];
        }
        
        
        
        
    }];


   
}

-(void)viewWillAppear:(BOOL)animated {
    // set tourist
   
}



- (IBAction)segmentedControlChanged:(id)sender {
    [self.tableViewDataSource changeTripsDisplayed];
    [self.tripTableView reloadData];
}


-(void)completeUser:(TRVUser*)guideForThisRow bio:(TRVBio*)bio parseUser:(PFUser*)user allTrips:(NSArray *)myTrips {
    
    
    for (PFObject *PFTour in myTrips){
        [PFTour fetch];
        TRVTour *tour = [[TRVTour alloc]init];
        tour.guideForThisTour = guideForThisRow;
        tour.categoryForThisTour = [TRVTourCategory returnCategoryWithTitle:PFTour[@"categoryForThisTour"]];
        tour.tourDeparture = PFTour[@"tourDeparture"];
        
        PFObject *PFItinerary = PFTour[@"itineraryForThisTour"];
        [PFItinerary fetch];
        
        TRVItinerary *itinerary = [[TRVItinerary alloc] init];
        itinerary.nameOfTour = PFItinerary[@"nameOfTour"];
        itinerary.numberOfStops =  [PFItinerary[@"numberOfStops"] integerValue];
        PFFile *imageForThisTour = PFItinerary[@"tourImage"];
        NSData *imageData = [imageForThisTour getData];
        itinerary.tourImage = [UIImage imageWithData:imageData];
        
        NSArray *tourStops = PFItinerary[@"tourStops"];
        NSMutableArray *TRVAllStops = [[NSMutableArray alloc] init];
        for (PFObject *PFStop in tourStops){
            [PFStop fetch];
            TRVTourStop *stop = [[TRVTourStop alloc] init];
            stop.lng = [PFStop[@"lng"] floatValue];
            stop.lat = [PFStop[@"lat"] floatValue];
            stop.nameOfPlace = PFStop[@"nameOfPlace"];
            stop.addressOfEvent = PFStop[@"addressOfEvent"];
            stop.descriptionOfEvent = PFStop[@"descriptionOfEvent"];
            PFFile *imageForStop = PFStop[@"image"];
            NSData *stopImageData = [imageForStop getData];
            stop.image = [UIImage imageWithData:stopImageData];
            [TRVAllStops addObject:stop];
        }
        
        itinerary.tourStops = TRVAllStops;
        tour.itineraryForThisTour = itinerary;
        [guideForThisRow.myTrips addObject:tour];
        
    } // END OF TOUR FOR LOOP
    
    NSLog(@"THESE ARE THE USER TRIPS %@",self.tourist.myTrips);
    
    }






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"tripDetailSegue"]) {
        TRVTouristTripTableViewCell *cell = sender;
        TRVTouristTripDetailViewController *vc = segue.destinationViewController;
        vc.tour = cell.tour;
    }
}


@end
