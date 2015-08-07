//
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

@interface TRVGuideResultsTableViewController ()<UIGestureRecognizerDelegate, FilterProtocol>


@property (nonatomic, strong) NSDictionary *filterDictionary;
@property (nonatomic, strong) TRVUserDataStore *sharedData;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.user = [[TRVUser alloc] init];
    
    
    self.user.userBio = [[TRVBio alloc] initTouristWithUserName:@"Ashley" firstName:@"Ashley" lastName:@"Madison" email:@"ashleyfromthe6@gmail.com" phoneNumber:7188866958 profileImage:[UIImage imageNamed:@"leo.jpg"] bioDescription:@"great person" interests:[NSMutableArray arrayWithObjects:@"hi", @"hi", nil] language:@"English"];
  
    self.user.userBio.homeCity = @"New York";
    self.user.userBio.homeCountry = @"United States";
    self.user.userBio.userTagline = @"Loves fried chicken and ramen. Super Spontaneous Person!";
    self.user.userBio.profileImage = [UIImage imageNamed:@"leo.jpg"];
    
    
    TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
    
    cell.guideForThisCell = self.user;
    
    UITapGestureRecognizer *singleTapOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [cell.profileImageViewNib addGestureRecognizer:singleTapOnImage];
    cell.profileImageViewNib.userInteractionEnabled = YES;
    
    return cell;
    
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

//    TRVDetailGuideViewController *destinationVC = segue.destinationViewController;
    }
}

-(void)passFilterDictionary:(NSDictionary *)dictionary{
    
    self.filterDictionary = dictionary;
    NSLog(@"The dictionary: %@", self.filterDictionary);
    
}

-(void)updateGuidesList {
    
    NSMutableArray *availableGuides = [[NSMutableArray alloc]init];
    
        // ADD LOADING HUD HERE BEFORE PARSE REQUEST GOES DOWN
    PFQuery *findGuidesQuery = [PFQuery queryWithClassName:@"UserBio"];
    
     [findGuidesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
         
         // WE NEED TO ADD A SEARCH BASED ON EAT,SEE,PLAY,DRINK
         for (PFObject *guideBio in objects){
             
             if ([guideBio[@"isGuide"] isEqualToNumber:@(YES)] && [guideBio[@"homeCity"] isEqualToString:self.selectedCity]){
                 
                 
                 NSLog(@"This is the parent: %@", guideBio[@"parent"]);
                 [availableGuides addObject:guideBio[@"parent"]];
                 
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


@end
