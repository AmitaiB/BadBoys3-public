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
#import "TRVBio.h"
#import "TRVSearchTripsViewController.h"
#import "TRVGuideProfileTableViewCell.h"
#import <Masonry/Masonry.h>
#import "TRVDetailGuideViewController.h"
#import "TRVFilterViewController.h"
#import "TRVUserDataStore.h"
#import "TRVAFNetwokingAPIClient.h"
#import <Parse.h>
#import "TRVTourStop.h"

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
    
    
    
    
    PFQuery *query = [PFUser query];
    [query includeKey:@"userBio"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        
        for (PFUser *user in objects){
            PFObject *guideBio = user[@"userBio"];
           // [guideBio fetch];
            
            if ([guideBio[@"isGuide"] isEqualToNumber:@(YES)] && [guideBio[@"homeCity"] isEqualToString:self.selectedCity]){
                
                TRVUser *guideForThisRow = [[TRVUser alloc]init];
                guideForThisRow.myTrips = [[NSMutableArray alloc]init];

                
                
                TRVBio *bio = [[TRVBio alloc]initGuideWithUserName:guideBio[@"name"]
                                                         firstName:guideBio[@"first_name"]
                                                          lastName:guideBio[@"last_name"]
                                                             email:guideBio[@"email"]
                                                       phoneNumber:guideBio[@"phoneNumber"]
                                                      profileImage:nil
                                                    bioDescription:guideBio[@"bioTextField"]
                                                         interests:nil language:guideBio[@"languagesSpoken"]
                                                               age:0 gender:guideBio[@"gender"]
                                                            region:nil
                                                    oneLineSummary:guideBio[@"oneLineBio"]
                                                   profileImageURL:guideBio[@"picture"]
                                                  nonFacebookImage:guideBio[@"emailPicture" ]];
                
                
                
                [TRVAFNetwokingAPIClient getImagesWithURL:guideBio[@"picture"] withCompletionBlock:^(UIImage *response) {
                    bio.profileImage = response;
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
                    guideForThisRow.userBio = bio;

                    
                    
                    
                    NSArray *allTours = user[@"myTrips"];
                    for (PFObject *PFTour in allTours){
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

                    [self.availableGuides addObject: guideForThisRow];
                    NSLog(@"My name is: %@", guideForThisRow.userBio.firstName);
                    [self.tableView reloadData];
                    
                }]; // END OF GET GUIDE IMAGE BLOCK
                

                
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