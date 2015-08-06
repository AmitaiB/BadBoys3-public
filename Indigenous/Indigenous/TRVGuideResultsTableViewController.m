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

@interface TRVGuideResultsTableViewController ()<UIGestureRecognizerDelegate, FilterProtocol>


@property (nonatomic, strong) NSDictionary *filterDictionary;

@end

@implementation TRVGuideResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  NSLog(@"City: %@,  Category: %@", self.selectedCity, self.dat)
    
}

-(void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
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
    
        TRVFilterViewController *filterModal = [segue destinationViewController];

        if (self.filterDictionary){
                filterModal.filterDictionary = self.filterDictionary;
            }
    
        filterModal.delegate = self;
    
    if([segue.identifier isEqualToString:@"detailGuideSegue"]) {

//    TRVDetailGuideViewController *destinationVC = segue.destinationViewController;
    }
}

-(void)passFilterDictionary:(NSDictionary *)dictionary{
    
    self.filterDictionary = dictionary;
    NSLog(@"The dictionary: %@", self.filterDictionary);
    
}

-(void)updateGuidesList {
        // LEO
        // THIS IS ALL YOU
        // KILL IT
        // OR MAYBE I CAN DO IT
        // BUT WE SHALL SEE
    
        if (self.filterDictionary == nil){
                NSLog(@"Filter is nil!");
        
                // SHOW ALL GUDES
        
            } else {
            
                // USE SELF.FILTERDICTIONARY TO FILTER THE GUIDES
            
        }
    
}


@end
