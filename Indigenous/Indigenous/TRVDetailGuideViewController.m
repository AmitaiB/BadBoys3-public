//
//  TRVDetailGuideViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/5/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVDetailGuideViewController.h"
#import "TRVUser.h"
#import "TRVUserSnippetView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import "TRVUserProfileImageView.h"
#import "TRVGuideTableView.h"
#import "TRVTouristTripDataSource.h"
#import "TRVUserDataStore.h"
#import "TRVTouristTripTableViewCell.h"
#import <Masonry.h>
#import "TRVTourStop.h"

@interface TRVDetailGuideViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (nonatomic, strong) TRVTouristTripDataSource *guideTripDataSource;

@end

@implementation TRVDetailGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    
    
    // dummy data for tour
    TRVTourStop *dummyTourStop = [[TRVTourStop alloc] init];
    NSMutableArray *tourStops = [[NSMutableArray alloc] initWithObjects:dummyTourStop,dummyTourStop, nil];
    TRVTour *aTour = [[TRVTour alloc] init];
    aTour.itineraryForThisTour = [[TRVItinerary alloc] initNameOfTour:@"Canada 6 Tour" tourImage:[UIImage imageNamed:@"madrid.jpg"] tourStops:tourStops];
    aTour.tourDeparture = [NSDate dateWithTimeIntervalSinceNow:1000];
    
    // instantiate data source
    self.guideTripDataSource = [[TRVTouristTripDataSource alloc] initWithTrips:@[aTour] configuration:nil];
    
    
    

    
    
    //Instantiate a Image View Nib
    
    TRVUserProfileImageView *profileImageView = [[TRVUserProfileImageView alloc] init];
    profileImageView.userForThisProfileImageView = self.selectedGuideUser;
    
    [self.profileView addSubview:profileImageView];
    [profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.profileView);
        make.height.equalTo(self.profileView.mas_width);
    }];
    
    
    //Instantiate a Snippet View Nib
    
    TRVUserSnippetView *snippetView = [[TRVUserSnippetView alloc] init];
    snippetView.userForThisSnippetView = self.selectedGuideUser;
    
    
    [self.profileView addSubview:snippetView];
    [snippetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileImageView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
    }];
    
    //Instantiate an ABOUT ME  Nib
    
    TRVUserAboutMeView *aboutMeView = [[TRVUserAboutMeView alloc] init];
    aboutMeView.userForThisAboutMeView = self.selectedGuideUser;
    
    [self.profileView addSubview:aboutMeView];
    [aboutMeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(snippetView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
        
    }];
    
    
    
    //Instantiate a Contact View Nib
    
    TRVUserContactView *contactView = [[TRVUserContactView alloc] init];
    contactView.userForThisContactView = self.selectedGuideUser;
    
    [self.profileView addSubview:contactView];
    [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aboutMeView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
    }];
    
    
    
//    Instantiate a Table View

    UITableView *guideTripsTableView = [[UITableView alloc] init];
    guideTripsTableView.delegate = self;
    guideTripsTableView.dataSource = self;
    [self.profileView addSubview:guideTripsTableView];
    [guideTripsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tripCell"];
    
    guideTripsTableView.backgroundColor = [UIColor orangeColor];
    
    [guideTripsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contactView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
        make.height.equalTo(@300);
    }];
    
    
    // Set Container View Constraints
    
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(guideTripsTableView.mas_bottom);
    }];
    
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tripCell" forIndexPath:indexPath];
 
 
 return cell;
 }
 
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // set height of first row
//    if (indexPath.row == 0) {
//        return 300;
//    }
//    return 50;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
