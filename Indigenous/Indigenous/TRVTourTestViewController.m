//
//  TRVTourTestViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourTestViewController.h"
#import "TRVItinerary.h"
#import "TRVTour.h"
#import "TRVTourStop.h"
#import "TRVUserDataStore.h"

@interface TRVTourTestViewController ()
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (weak, nonatomic) IBOutlet TRVTourView *tourNibVIew;
@property (nonatomic, strong) TRVItinerary *testItinerary;
@end

@implementation TRVTourTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    // Do any additional setup after loading the view.
    
    TRVTour *testTour = [[TRVTour alloc] initWithGuideUser:self.sharedDataStore.loggedInUser itineraryForThisTour:self.testItinerary];
    
    TRVTourStop *dummyTourStop = [[TRVTourStop alloc] init];
    
    NSMutableArray *tourStops = [[NSMutableArray alloc] initWithObjects:dummyTourStop,dummyTourStop, nil];
    
    
    self.testItinerary = [[TRVItinerary alloc] initNameOfTour:@"Canada 6 Tour" tourImage:[UIImage imageNamed:@"madrid.jpg"] tourStops:tourStops];
    testTour.itineraryForThisTour = self.testItinerary;

    
    // setting tour this this view
    self.tourNibVIew.tourForThisTourView = testTour;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
