//
//  TRVGuideResultsTableViewController

//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSMutableArray+extraMethods.h"
#import "TRVGuideResultsTableViewController.h"
#import "TRVTour.h"
#import "TRVUser.h"
#import "TRVTourStop.h"
#import "TRVBio.h"
#import "TRVSearchTripsViewController.h"
#import "TRVGuideProfileTableViewCell.h"
#import <Masonry/Masonry.h>
#import "TRVDetailGuideViewController.h"
#import "TRVFilterViewController.h"
#import "TRVUserDataStore.h"
#import "TRVAFNetwokingAPIClient.h"
#import <Parse.h>

@interface TRVGuideResultsTableViewController ()<UIGestureRecognizerDelegate, FilterProtocol, ImageTapProtocol>


@property (nonatomic, strong) NSDictionary *filterDictionary;
@property (nonatomic, strong) TRVUserDataStore *sharedData;
@property (nonatomic, strong) NSMutableArray *availableGuides;
@property (nonatomic, strong) TRVUser *destinationGuideUser;
//@property (nonatomic, strong) TRVGuideResultsDataSource *tableViewDataSource;

@end

@implementation TRVGuideResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateGuidesList];

    self.sharedData = [TRVUserDataStore sharedUserInfoDataStore];


}

-(void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
        [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@" NUMBER OF USERS!!!! %lu" , (unsigned long)self.availableGuides.count);
    return self.availableGuides.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 350;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.availableGuides.count > 0){
            
    TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
        
        cell.guideForThisCell = self.availableGuides[indexPath.row];
        
       // setting nib user will parse text labels
        cell.profileImageViewNib.userForThisGuideProfileView = self.availableGuides[indexPath.row];
        
        // I CONFORM TO THE PROFILE IMAGE TAPPED PROTOCOL
        cell.profileImageViewNib.delegate = self;
        
    // add ibaction programaticcaly
        
    return cell;
    }
    else {
        
        // show a modal or something....
        NSLog(@"THERE ARE NO AVAILABLE GUIDES IN THIS SEARCH RESULT");
        TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
        return cell;
    }
}


- (void)returnUserForThisImageNib:(TRVUser *)guideUser {
    self.destinationGuideUser = guideUser;
    [self performSegueWithIdentifier:@"detailGuideSegue" sender:nil];
    NSLog(@"DOES THIS WORK????? THIS IS THE DELEGATE METHOD FOR NIB: %@", guideUser.userBio.firstName);
}




-(void)passFilterDictionary:(NSDictionary *)dictionary{
    
    self.filterDictionary = dictionary;
    NSLog(@"The dictionary: %@", self.filterDictionary);
}

-(void)updateGuidesList {
    
    self.availableGuides = [[NSMutableArray alloc]init];
        // ADD LOADING HUD HERE BEFORE PARSE REQUEST GOES DOWN
    
    
//    PFQuery *findGuidesQuery = [PFQuery queryWithClassName:@"UserBio"];
//      PFQuery *findGuidesQuery = [PFQuery queryWithClassName:@"Itinerary"];
    PFQuery *query = [PFUser query];
    

    NSMutableArray *TRVallTrips = [[NSMutableArray alloc] init];

    
     [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
         // WE NEED TO ADD A SEARCH BASED ON EAT,SEE,PLAY,DRINK
//         NSLog(@"%@" ,objects);

         for (PFUser *user in objects){
             
        PFObject *guideBio = user[@"userBio"];
             [guideBio fetch];
             

             
             if ([guideBio[@"isGuide"] isEqualToNumber:@(YES)] && [guideBio[@"homeCity"] isEqualToString:self.selectedCity]){

                 TRVBio *bio = [[TRVBio alloc]initGuideWithUserName:guideBio[@"name"]
                                                          firstName:guideBio[@"first_name"]
                                                           lastName:guideBio[@"last_name"]
                                                              email:guideBio[@"email"]
                                                        phoneNumber:guideBio[@"phoneNumber"]
                                                       profileImage:nil
                                                     bioDescription:guideBio[@"bioTextField"]
                                                          interests:nil
                                                           language:guideBio[@"languagesSpoken"]
                                                                age:0 gender:guideBio[@"gender"]
                                                             region:nil
                                                     oneLineSummary:guideBio[@"oneLineBio"]
                                                    profileImageURL:guideBio[@"picture"]
                                                   nonFacebookImage:guideBio[@"emailPicture"]];
                 
                 
                 TRVUser *guideForThisRow = [[TRVUser alloc]initWithBio:bio];
                 
                 NSArray *allTripsFromParse = user[@"myTrips"];
                 NSLog(@"THIS IS THE ALL TRIPS ARRAY %@", allTripsFromParse);
                 
//                 NSMutableArray *TRVallTrips = [[NSMutableArray alloc] init];
                 for (PFObject *PFtour in allTripsFromParse) {
                     [PFtour fetch];
                     TRVTour *tourForThisIteration = [[TRVTour alloc] init];
                     tourForThisIteration.guideForThisTour = guideForThisRow;
//                     tourForThisIteration.itineraryForThisTour = nil;
                     tourForThisIteration.categoryForThisTour.categoryName = PFtour[@"categoryForThisTour"];
                     tourForThisIteration.tourDeparture = PFtour[@"tourDeparture"];
                     NSLog(@"%@ THIS IS THE CATEGORY NAME OF TOUR", tourForThisIteration.categoryForThisTour);
                     [TRVallTrips addObject:tourForThisIteration];
                     
                     

                     // GET ITINERARY IN QUERY
                     
                     PFObject *PFItinerary = PFtour[@"itineraryForThisTour"];
                     
//                     for (PFObject *PFItinerary in allTripsFromParse) {
                         [PFItinerary fetch];
                         TRVItinerary *itineraryForTour = [[TRVItinerary alloc] initNameOfTour:PFItinerary[@"nameOfTour"] tourImage:nil tourStops:nil];
                         
                         NSArray *allTripsArray = PFItinerary[@"tourStops"];

                         // GET TOUR STOPS IN QUERY
                         NSMutableArray *TRVallStops = [[NSMutableArray alloc] init];
                         
                         for (PFObject *PFtourStop in allTripsArray) {
                             [PFtourStop fetch];
                             TRVTourStop *TRVstop = [[TRVTourStop alloc] init];
                             // uncomment when the parse column is PFGeopoint
//                             tourStop.lng = PFtourStop[@"lng"];
//                             tourStop.lat = PFtourStop[@"lat"];
                             TRVstop.nameOfPlace = @"Tour Stop Place";
                             [TRVallStops addObject:TRVstop];
                         }
                         
                         itineraryForTour.tourStops = TRVallStops;
                         tourForThisIteration.itineraryForThisTour = itineraryForTour;
                         tourForThisIteration.guideForThisTour = guideForThisRow;
                         // THIS IS THE MAGIC LINE
                         [TRVallTrips addObject:tourForThisIteration];
//                     }

                     
                     
                     
                 }
                 
                 
                 
                 
                 // IMAGE PARSING ON PARSE
                 [TRVAFNetwokingAPIClient getImagesWithURL:guideBio[@"picture"] withCompletionBlock:^(UIImage *response) {
                     
                     bio.profileImage = response;

                     
                     // Check to see if guide is signed up with email rather than FB
                     // if there is no URL, then parse the PF file image
                     
                     if (![guideBio objectForKey:@"picture"]) {
                         NSLog(@"DO YOU EVER GET CALLED?");
                         PFFile *pictureFile = objects[0][@"emailPicture"];
                         [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                             if (!error) {
                                 bio.nonFacebookImage = [UIImage imageWithData:data];
                             } else {
                                 // error block
                             }
                         }];
                     }// END OF TRVAFNetwokingAPIClient GET IMAGE METHOD
                     
                     
                     

                     
                     
                     // UNCOMMENT THIS WHEN WE CAN ACTUALLY ADD TRIPS UP TO PARSE
                     // guideForThisRow.myTrips = theParseGuide[@"myTrips"];
                     //  if (theParseGuide[@"myTrips"]){
                     
                     
                         // ADDED DUMMY DATA STORED IN NSMUTABLE ARRAY CATEGORY
//                         NSMutableArray *dummyAllTrips = [[NSMutableArray alloc] init];
                     
                     
                     PFQuery *query = [PFQuery queryWithClassName:@"Tour"];
                     
                     // THIS ONE LINE MAKES SURE YOU ARE GETTING YOUR ENTRY AND NOT ANOTHER USERS
                     [query whereKey:@"guideForThisTour" equalTo:@"Drink"];
                     
                     [query orderByDescending:@"createdAt"];
                     
                     

                     
                     [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
                         if (error) {
                             NSLog(@" THIS IS THE ERRORRR -------%@", error);
                         } else {
                             //---------------------------------------------------------------------------------------------------

                             // WE ARE GETTING AN  THE PFTOURS
                    
                             //------------------~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                             PFObject *currentItinerary = objects[0][@"itineraryForThisTour"];
                             [currentItinerary fetch];
                             NSLog(@"THIS IS NAME OF TOUR AT INDEX %@--------------- ", currentItinerary[@"nameOfTour"]);
                             NSArray *currentTourStops = currentItinerary[@"tourStops"];
                             PFObject *tourStop = currentTourStops[0];
                             [tourStop fetch];
                             NSLog(@"THIS IS THE OBJECT ID OF THE TOUR STOP %@", tourStop);
                             NSLog(@"%lu", objects.count);
                             NSLog(@"THIS IS THE LAT   =========  %@", tourStop[@"lat"]);
                             
//                             for (PFObject *PFTour in objects) {
//                                 TRVTO
//                             }
//                             
//                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             //---------------------------------------------------------------------------------------------------

                         }
                     }];
                     
            
                     
                     
//                     NSMutableArray *allTrips = [dummyAllTrips returnDummyAllTripsArrayForGuide:guideForThisRow];

//                         NSMutableArray *allTrips = [dummyAllTrips returnDummyAllTripsArrayForGuide:guideForThisRow];
//                         guideForThisRow.allTrips = allTrips;
                     
                     
                     
                     guideForThisRow.allTrips = TRVallTrips;
                     self.sharedData.loggedInUser.allTrips = TRVallTrips;

                     // ADDING GUIDE WHO MET CONDITIONS AS YES
                     [self.availableGuides addObject: guideForThisRow];
                     NSLog(@"My name is: %@", guideForThisRow.userBio.firstName);
                     [self.tableView reloadData];
                 }];
                 NSLog(@"NUMBER OF GUIDES AVAILABLE AFTER CONDITION: %lu!!!!!", (unsigned long)self.availableGuides.count);
                 
             }
        }
     }];
    
    
        if (self.filterDictionary == nil){
                NSLog(@"Filter is nil!");
            
                // SHOW ALL GUDES

                } else {
                // USE SELF.FILTERDICTIONARY TO FILTER THE GUIDES
        }
}









-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"showFilter"]) {
        TRVFilterViewController *filterModal = [segue destinationViewController];
        if (self.filterDictionary){
            filterModal.filterDictionary = self.filterDictionary;
        }
        filterModal.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"detailGuideSegue"]) {
        
//        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        
//        TRVUser *destinationGuideUser = self.availableGuides[ip.row];
        
        TRVDetailGuideViewController *destinationVC = segue.destinationViewController;
        destinationVC.selectedGuideUser = self.destinationGuideUser;
        
    }
    
}


@end
