//
//  TRVGuideResultsTableViewController

//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

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

@interface TRVGuideResultsTableViewController ()<UIGestureRecognizerDelegate, FilterProtocol>


@property (nonatomic, strong) NSDictionary *filterDictionary;
@property (nonatomic, strong) TRVUserDataStore *sharedData;
@property (nonatomic, strong) NSMutableArray *availableGuides;
@end

@implementation TRVGuideResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedData = [TRVUserDataStore sharedUserInfoDataStore];
   
    
}

-(void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
        NSLog(@"City: %@,  Category: %@", self.selectedCity, self.sharedData.currentCategorySearching);
        [self updateGuidesList];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 350;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.availableGuides.count > 0){
        self.user = [[TRVUser alloc]initWithBio:[self.availableGuides[indexPath.row] userBio]];

        NSLog(@"Image is: %@", self.user.userBio.profileImage);

    
    TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
    
    cell.guideForThisCell = self.user;
    cell.profileImageViewNib.userForThisGuideProfileView = self.user;
    UITapGestureRecognizer *singleTapOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [cell.profileImageViewNib addGestureRecognizer:singleTapOnImage];
    cell.profileImageViewNib.userInteractionEnabled = YES;
    
    return cell;
    } else {
        TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
        return cell;
    }
}






-(void)singleTap:(TRVGuideProfileTableViewCell *)cell {
    NSLog(@"In Single Tap Methood");

    [self performSegueWithIdentifier:@"detailGuideSegue" sender:cell];
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


    TRVDetailGuideViewController *destinationVC = segue.destinationViewController;
        destinationVC.selectedGuideUser = self.user;
    }
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
         
         // WE NEED TO ADD A SEARCH BASED ON EAT,SEE,PLAY,DRINK
         for (PFObject *guideBio in objects){
             
             if ([guideBio[@"isGuide"] isEqualToNumber:@(YES)] && [guideBio[@"homeCity"] isEqualToString:self.selectedCity]){
                 
                 PFUser *theParseGuide = guideBio[@"user"];
                 [theParseGuide fetch];
                 //NSLog(@"Bio: %@ \n Guide: %@", guideBio, theParseGuide);
                 
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
                                   profileImageURL:guideBio[@"picture"]];
                     
                     
                     TRVUser *guide = [[TRVUser alloc]initWithBio:bio];
                     if (theParseGuide[@"myTrips"]){
                         guide.myTrips = theParseGuide[@"myTrips"];
                     }
                     
                     [self.availableGuides addObject:guide];
                     NSLog(@"My image is: %@", guide.userBio.profileImage);
                     [self.tableView reloadData];
                 }];
                 
                 
                
             }
             
             
         }
         
         NSLog(@"Available Guides: %@", self.availableGuides);

     }];
    
    
        if (self.filterDictionary == nil){
                NSLog(@"Filter is nil!");
        
                // SHOW ALL GUDES
        
            
        
                } else {
            
                // USE SELF.FILTERDICTIONARY TO FILTER THE GUIDES
            
        }
    
}


@end
