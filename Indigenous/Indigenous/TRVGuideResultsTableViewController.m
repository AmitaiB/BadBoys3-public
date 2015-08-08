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
        [self updateGuidesList];
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
        
    // add ibaction programaticcaly
        
    UITapGestureRecognizer *singleTapOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [cell.profileImageViewNib addGestureRecognizer:singleTapOnImage];
    cell.profileImageViewNib.userInteractionEnabled = YES;
    
    return cell;
    }
    else {
        NSLog(@"THERE ARE NO AVAILABLE GUIDES IN THIS SEARCH RESULT");
        TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
        return cell;
    }
}





// add function to image tag
-(void)singleTap:(TRVGuideProfileTableViewCell *)cell {
    NSLog(@"In Single Tap Methood %@", cell);
    [self performSegueWithIdentifier:@"detailGuideSegue" sender:nil];
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
                     
                     TRVUser *guideForThisRow = [[TRVUser alloc]initWithBio:bio];
                     
                     if (theParseGuide[@"myTrips"]){
                         guideForThisRow.myTrips = theParseGuide[@"myTrips"];
                     }
                     
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
         NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        TRVUser *destinationGuideUser = self.availableGuides[ip.row];
        TRVDetailGuideViewController *destinationVC = segue.destinationViewController;
        destinationVC.selectedGuideUser = self.availableGuides[ip.row];
        NSLog(@"PERFORMING SEGUE WITH USER PASSING AS: %@", destinationGuideUser.userBio.firstName);
    }
    
}


@end
