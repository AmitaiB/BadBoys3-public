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
@property (weak, nonatomic) IBOutlet UILabel *nameOfTourLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfTourLabel;
@property (weak, nonatomic) IBOutlet UILabel *tourGuideForThisLabel;


@property (weak, nonatomic) IBOutlet UILabel *guideFullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *guideProfileImageLabel;
@property (weak, nonatomic) IBOutlet UILabel *guideTaglineLabel;
@property (weak, nonatomic) IBOutlet UILabel *guideCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *guideCountryLabel;



@end

@implementation TRVBookTourTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    self.nameOfTourLabel.text = self.destinationTour.itineraryForThisTour.nameOfTour;
//    self.dateOfTourLabel.text = self.destinationTour.tourDeparture;
    
    
    
    NSString *guideFirstName = self.destinationTour.guideForThisTour.userBio.firstName;
    NSString *guideLastName = self.destinationTour.guideForThisTour.userBio.lastName;

    
    self.tourGuideForThisLabel.text = [NSString stringWithFormat:@"with %@", guideFirstName];
    
    
    self.guideFullNameLabel.text = [NSString stringWithFormat:@"%@ %@" , guideFirstName, guideLastName];
    
    self.guideTaglineLabel.text = self.destinationTour.guideForThisTour.userBio.userTagline;
    
    self.guideCityLabel.text = self.destinationTour.guideForThisTour.userBio.homeCity;
    
    self.guideCityLabel.text = self.destinationTour.guideForThisTour.userBio.homeCountry;

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

    PFUser *currentUser = [PFUser currentUser];
  
    self.destinationPFTour[@"isPurchased"] = @(YES);
    self.destinationPFTour[@"tourDeparture"] = self.destinationTour.tourDeparture;
//    self.destinationPFTour[@"guideForThisTour"] =
    
    [currentUser addObject:self.destinationPFTour forKey:@"myTrips"];
    [currentUser save];
    
    
    if ([self.destinationTour.categoryForThisTour.categoryName isEqualToString:self.sharedDataStore.currentCategorySearching.categoryName]) {
        
//        
//        [self.sharedDataStore.loggedInUser.PFallTrips addObject:self.destinationPFTour];
//        currentUser[@"myTrips"] setArray:;
        
        

    }

    // LOGIC FOR CREATING A TOUR
    
    
}


@end
