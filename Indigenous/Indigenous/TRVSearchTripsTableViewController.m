//
//  TRVSearchTripsTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVSearchTripsTableViewController.h"
#import "TRVUser.h"
#import "TRVBio.h"
#import "TRVSearchTripsViewController.h"
#import "TRVSearchResultsDataSource.h"
#import "TRVGuideProfileTableViewCell.h"
#import <Masonry/Masonry.h>


@interface TRVSearchTripsTableViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) TRVGuideProfileTableViewCell *cell;


@end

@implementation TRVSearchTripsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTapToProfileImageView];
    
    // set datasource file
//    self.resultsDataSource = [[TRVSearchResultsDataSource alloc] init];
//    self.tableView.dataSource = self.resultsDataSource;

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
    
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
    self.cell.guideForThisCell = self.user;
    
    
    return self.cell;
    
}


-(void)addTapToProfileImageView {
    NSLog(@"Are yoe in here?");
    [self.cell.profileImageViewNib setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.cell addGestureRecognizer:singleTap];
    singleTap.delegate = self;
}

- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    
[self.navigationController performSegueWithIdentifier:@"detailTourGuideSegue" sender:nil];
    
}




@end
