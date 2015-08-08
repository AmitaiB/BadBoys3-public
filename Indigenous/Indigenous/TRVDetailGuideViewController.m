//
//  TRVDetailGuideViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/5/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSMutableArray+extraMethods.h"

#import "TRVDetailGuideViewController.h"
#import "TRVUser.h"
#import "TRVUserSnippetView.h"
#import "TRVTourView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import "TRVUserProfileImageView.h"
#import "TRVTouristTripDataSource.h"
#import "TRVUserDataStore.h"
#import "TRVTouristTripTableViewCell.h"
#import <Masonry.h>
#import "TRVTourStop.h"

@interface TRVDetailGuideViewController ()<UITableViewDelegate, UITableViewDataSource>


//@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (nonatomic, strong) TRVTouristTripDataSource *guideTripDataSource;
@property (nonatomic, strong) UITableView *guideTripsTableView;

@end

@implementation TRVDetailGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"WHO AM IIIII? %@", self.selectedGuideUser.userBio.firstName);
//    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    
    
    // dummy data for tour
    TRVTourStop *dummyTourStop = [[TRVTourStop alloc] init];
    NSMutableArray *tourStops = [[NSMutableArray alloc] initWithObjects:dummyTourStop,dummyTourStop, nil];
    TRVTour *aTour = [[TRVTour alloc] init];
    aTour.itineraryForThisTour = [[TRVItinerary alloc] initNameOfTour:@"Canada 6 Tour" tourImage:[UIImage imageNamed:@"madrid.jpg"] tourStops:tourStops];
    aTour.tourDeparture = [NSDate dateWithTimeIntervalSinceNow:1000];
    
//    NSMutableArray *dummyAllTrips = [[NSMutableArray alloc] init];
//    [dummyAllTrips returnDummyAllTripsArrayForGuide:self.selectedGuideUser];
//    
    
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
    
    //    Instantiate a Segmented Control View

    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Food", @"Other Tours", nil]];
    segmentedControl.frame = CGRectMake(35, 200, 250, 50);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 0;
//    segmentedControl.tintColor = [UIColor blackColor];
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    
    
    [self.profileView addSubview:segmentedControl];
    
    
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contactView.mas_bottom).with.offset(10);
        make.left.equalTo(self.profileView).with.offset(10);
        make.right.equalTo(self.profileView).with.offset(-10);
    }];

    
//    Instantiate a Table View

    self.guideTripsTableView = [[UITableView alloc] init];
    self.guideTripsTableView.delegate = self;
    self.guideTripsTableView.dataSource = self;
    [self.profileView addSubview:self.guideTripsTableView];
 
    
    // Register cell
    [self.guideTripsTableView registerClass:[TRVTouristTripTableViewCell class] forCellReuseIdentifier:@"tripCell"];
    
    self.guideTripsTableView.backgroundColor = [UIColor orangeColor];
    
    [self.guideTripsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentedControl.mas_bottom).with.offset(10);
        make.left.and.right.equalTo(self.profileView);
        make.height.equalTo(@2000);
    }];
    
    
    // Set Table View Constraints
    
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.guideTripsTableView.mas_bottom);
    }];
    
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     
     
     
 TRVTouristTripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tripCell" forIndexPath:indexPath];
     
//      DUMMY DATA
     TRVTourStop *dummyTourStop = [[TRVTourStop alloc] init];
     
     NSMutableArray *tourStops = [[NSMutableArray alloc] initWithObjects:dummyTourStop,dummyTourStop, nil];
     
     TRVTour *aTour = [[TRVTour alloc] init];
     aTour.itineraryForThisTour = [[TRVItinerary alloc] initNameOfTour:@"Canada 6 Tour" tourImage:[UIImage imageNamed:@"madrid.jpg"] tourStops:tourStops];
     
     aTour.tourDeparture = [NSDate dateWithTimeIntervalSinceNow:1000];

     
     TRVTourView *tourView = [[TRVTourView alloc] init];
     [cell addSubview:tourView];


     [tourView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.and.left.and.right.equalTo(cell).with.offset(5);
         make.right.equalTo(cell).with.offset(-5);
         make.bottom.equalTo(cell.mas_bottomMargin).with.offset(10);
     }];
     
     tourView.tourForThisTourView = aTour;
     tourView.backgroundColor = [UIColor redColor];
     
     
     self.guideTripsTableView.estimatedRowHeight = 300;
//     self.guideTripsTableView.rowHeight = UITableViewAutomaticDimension;

     
     NSLog(@"%@",cell.tour);
 
 
     return cell;
     
 }
 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return 300;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
