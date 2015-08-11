//
//  TRVGuideResultsTableViewController

//  Indigenous
//
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSMutableArray+extraMethods.h"
#import "TRVGuideResultsTableViewController.h"
#import "TRVUser.h"
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
        
        // TODO show a modal or something....
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
    
    
    PFQuery *findGuidesQuery = [PFQuery queryWithClassName:@"UserBio"];
    
     [findGuidesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
         
         // TODO WE NEED TO ADD A SEARCH BASED ON EAT,SEE,PLAY,DRINK
         for (PFObject *guideBio in objects){
             NSLog(@"HOW MANY OBJECTS WE GET BACK IN PARSE QUERY: %lu" , (unsigned long)objects.count);
             
             if ([guideBio[@"isGuide"] isEqualToNumber:@(YES)] && [guideBio[@"homeCity"] isEqualToString:self.selectedCity]){
                
                     PFUser *theParseGuide = guideBio[@"user"];
                     [theParseGuide fetch];
                 
                 [TRVAFNetwokingAPIClient getImagesWithURL:guideBio[@"picture"] withCompletionBlock:^(UIImage *response) {
                     
                    
                TRVBio *bio = [[TRVBio alloc]initGuideWithUserName:guideBio[@"name"]
                                         firstName:guideBio[@"first_name"]
                                          lastName:guideBio[@"last_name"]
                                             email:guideBio[@"email"]
                                       phoneNumber:guideBio[@"phoneNumber"]
                                      profileImage:response
                                    bioDescription:guideBio[@"bioTextField"]
                                         interests:nil language:guideBio[@"languagesSpoken"]
                                               age:0 gender:guideBio[@"gender"]
                                            region:nil
                                    oneLineSummary:guideBio[@"oneLineBio"]
                                   profileImageURL:guideBio[@"picture"]
                                    nonFacebookImage:guideBio[@"emailPicture" ]];
                     
                     //---------------------------------------------------------------------------------------------------
                     
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
                     }
                     //---------------------------------------------------------------------------------------------------

                     
                     TRVUser *guideForThisRow = [[TRVUser alloc]initWithBio:bio];
                     
                     // UNCOMMENT THIS WHEN WE CAN ACTUALLY ADD TRIPS UP TO PARSE
                     // guideForThisRow.myTrips = theParseGuide[@"myTrips"];
                     //  if (theParseGuide[@"myTrips"]){
                     
                     //---------------------------------------------------------------------------------------------------

                         // ADDED DUMMY DATA STORED IN NSMUTABLE ARRAY CATEGORY
                         NSMutableArray *dummyAllTrips = [[NSMutableArray alloc] init];
                     
                     
                     PFQuery *query = [PFQuery queryWithClassName:@"Tour"];
                     
                     // THIS ONE LINE MAKES SURE YOU ARE GETTING YOUR ENTRY AND NOT ANOTHER USERS
                     [query whereKey:@"categoryForThisTour" equalTo:@"Drink"];
                     
                     [query orderByDescending:@"createdAt"];
                     
                     [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
                         if (error) {
                             NSLog(@" THIS IS THE ERRORRR -------%@", error);
                         } else {
                             PFObject *currentItinerary = objects[0][@"itineraryForThisTour"];
                             [currentItinerary fetch];
                             NSLog(@"THIS IS NAME OF TOUR AT INDEX %@--------------- ", currentItinerary[@"nameOfTour"]);
                             NSArray *currentTourStops = currentItinerary[@"tourStops"];
                             PFObject *tourStop = currentTourStops[0];
                             [tourStop fetch];
                             NSLog(@"THIS IS THE OBJECT ID OF THE TOUR STOP %@", tourStop);
                             NSLog(@"%lu", objects.count);
                             NSLog(@"THIS IS THE LAT   =========  %@", tourStop[@"lat"]);
                         }
                     }];
                     
                 

                     
                     
                     
                         NSMutableArray *allTrips = [dummyAllTrips returnDummyAllTripsArrayForGuide:guideForThisRow];
                         guideForThisRow.allTrips = allTrips;
//                     }
                     //---------------------------------------------------------------------------------------------------

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
