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
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
//    
//    TRVTourStop *dummyTourStop = [[TRVTourStop alloc] init];
//    
//    NSMutableArray *tourStops = [[NSMutableArray alloc] initWithObjects:dummyTourStop,dummyTourStop, nil];
//    
//    TRVTour *aTour = [[TRVTour alloc] init];
//    aTour.itineraryForThisTour = [[TRVItinerary alloc] initNameOfTour:@"Canada 6 Tour" tourImage:[UIImage imageNamed:@"madrid.jpg"] tourStops:tourStops];
//
//    aTour.tourDeparture = [NSDate dateWithTimeIntervalSinceNow:1000];
////    aTour.itineraryForThisTour.tourImage = [UIImage imageNamed:@"Carmelo.jpg"];
//    
//    
//    
//        NSMutableArray *dummyAllTrips = [[NSMutableArray alloc] init];
//        NSMutableArray *allTrips = [dummyAllTrips returnDummyAllTripsArrayForGuide:self.sharedDataStore.loggedInUser];
//    
//    
//    
//    
//    self.tableViewDataSource = [[TRVTouristTripDataSource alloc] initWithTrips:allTrips configuration:nil];
//    self.tripTableView.dataSource = self.tableViewDataSource;
}

-(void)viewWillAppear:(BOOL)animated {

    
    TRVTourStop *dummyTourStop = [[TRVTourStop alloc] init];

    NSMutableArray *tourStops = [[NSMutableArray alloc] initWithObjects:dummyTourStop,dummyTourStop, nil];
    
    TRVTour *aTour = [[TRVTour alloc] init];
    aTour.itineraryForThisTour = [[TRVItinerary alloc] initNameOfTour:@"Canada 6 Tour" tourImage:[UIImage imageNamed:@"madrid.jpg"] tourStops:tourStops];
    
    aTour.tourDeparture = [NSDate dateWithTimeIntervalSinceNow:1000];
    //    aTour.itineraryForThisTour.tourImage = [UIImage imageNamed:@"Carmelo.jpg"];
    
    
    
    NSMutableArray *dummyAllTrips = [[NSMutableArray alloc] init];
    NSMutableArray *allTrips = [dummyAllTrips returnDummyAllTripsArrayForGuide:self.sharedDataStore.loggedInUser];
    
    
    
    
    self.tableViewDataSource = [[TRVTouristTripDataSource alloc] initWithTrips:allTrips configuration:nil];
    self.tripTableView.dataSource = self.tableViewDataSource;
}

- (IBAction)segmentedControlChanged:(id)sender {
    [self.tableViewDataSource changeTripsDisplayed];
    [self.tripTableView reloadData];
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
