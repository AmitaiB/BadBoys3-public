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


@interface TRVGuideResultsTableViewController ()<UIGestureRecognizerDelegate>



@end

@implementation TRVGuideResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    if([segue.identifier isEqualToString:@"detailGuideSegue"]) {

    TRVDetailGuideViewController *destinationVC = segue.destinationViewController;
        destinationVC.selectedGuideUser = self.user;
    }
}


@end
