//
//  TRVGuideResultsTableViewController

//  Indigenous
//
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSMutableArray+extraMethods.h"
#import "TRVGuideResultsTableViewController.h"
#import "TRVTour.h"
#import "TRVUser.h"
#import "TRVTourStop.h"
#import "TRVTourCategory.h"
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
    [self.tableView reloadData];

    self.sharedData = [TRVUserDataStore sharedUserInfoDataStore];


}

-(void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
        [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
        
        // TODO show a modal or something....
        NSLog(@"THERE ARE NO AVAILABLE GUIDES IN THIS SEARCH RESULT");
        TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
        return cell;
    }
}


- (void)returnUserForThisImageNib:(TRVUser *)guideUser {
    self.destinationGuideUser = guideUser;
    [self performSegueWithIdentifier:@"detailGuideSegue" sender:nil];
}




-(void)passFilterDictionary:(NSDictionary *)dictionary{
    
    self.filterDictionary = dictionary;
    NSLog(@"The dictionary: %@", self.filterDictionary);
}

-(void)updateGuidesList {
    
    self.availableGuides = [[NSMutableArray alloc]init];
        // ADD LOADING HUD HERE BEFORE PARSE REQUEST GOES DOWN
    

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
                 
                 // GET Tours IN QUERY
                 
                 for (PFObject *PFtour in allTripsFromParse) {
                     [PFtour fetch];
                     TRVTour *tourForThisIteration = [[TRVTour alloc] init];
                     tourForThisIteration.guideForThisTour = guideForThisRow;
                     NSString *categoryForThisTour = PFtour[@"categoryForThisTour"];
                     tourForThisIteration.categoryForThisTour = [TRVTourCategory returnCategoryWithTitle:categoryForThisTour];
                     tourForThisIteration.tourDeparture = PFtour[@"tourDeparture"];
                     NSLog(@"%@ THIS IS THE CATEGORY NAME OF TOUR", tourForThisIteration.categoryForThisTour);
                     
                     

                     // GET ITINERARY IN QUERY
                     
                     PFObject *PFItinerary = PFtour[@"itineraryForThisTour"];
                     
                         [PFItinerary fetch];
                         TRVItinerary *itineraryForTour = [[TRVItinerary alloc] initNameOfTour:PFItinerary[@"nameOfTour"] tourImage:nil tourStops:nil];
                     
                        // PULL TOUR IMAGE DOWN (IN ITINERARY CLASS)
                     PFFile *imageForThisTour = PFItinerary[@"tourImage"];
                     
                     [imageForThisTour getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                         if (!error) {
                             itineraryForTour.tourImage = [UIImage imageWithData:data];
                             
                         } else {
                             // error block
                             
                         }
                     }];

                     
                         
                         NSArray *allTripsArray = PFItinerary[@"tourStops"];
                         // GET TOUR STOPS IN QUERY
                         NSMutableArray *TRVallStops = [[NSMutableArray alloc] init];
                     
                     // GET Tour Stop IN QUERY

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
                     NSLog(@"NUMBER OF LINES, %@", TRVallTrips);
                     
                     
                     
                 } // end of PFTOUR IN ALLTRIPS FOR LOOP
                 NSLog(@"NUMBER OF AVAILABLE GUIDES %ld", self.availableGuides.count);
                 
                 // IMAGE PARSING ON PARSE
                 [TRVAFNetwokingAPIClient getImagesWithURL:guideBio[@"picture"] withCompletionBlock:^(UIImage *response) {
                     
                     bio.profileImage = response;
                     [self.tableView reloadData];

                     
                     // Check to see if guide is signed up with email rather than FB
                     // if there is no URL, then parse the PF file image
                     
                     if (![guideBio objectForKey:@"picture"]) {
                         PFFile *pictureFile = objects[0][@"emailPicture"];
                         [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                             if (!error) {
                                 bio.nonFacebookImage = [UIImage imageWithData:data];
                             } else {
                                 // error block
                             }
                         }];
                         
                         
                         
                         
                     }// END OF TRVAFNetwokingAPIClient GET IMAGE METHOD
                     
                     
//                     
//                     
//                     NSMutableArray *allTrips = [dummyAllTrips returnDummyAllTripsArrayForGuide:guideForThisRow];

//                         NSMutableArray *allTrips = [dummyAllTrips returnDummyAllTripsArrayForGuide:guideForThisRow];
//                         guideForThisRow.allTrips = allTrips;
                     
                     
                     
                     guideForThisRow.allTrips = TRVallTrips;
                     self.sharedData.loggedInUser.allTrips = TRVallTrips;

                     // ADDING GUIDE WHO MET CONDITIONS AS YES
                     [self.availableGuides addObject: guideForThisRow];
                     NSLog(@"My name is: %@", guideForThisRow.userBio.firstName);
                     [self.tableView reloadData];
                 }]; //  END OF GET IMAGES BLOCK
                 
                 
                 
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
    [self.tableView reloadData];

    
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
