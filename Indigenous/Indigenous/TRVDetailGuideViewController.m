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
//    self.guideTripsTableView.estimatedRowHeight = 300;
//    self.guideTripsTableView.rowHeight = UITableViewAutomaticDimension;

    NSLog(@"%@", self.selectedGuideUser.allTrips);
    
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

    // hide send me to tourguidetab button
        [aboutMeView.switchToGuideButton setHidden:YES];
    //make button shrink
        [aboutMeView.switchToGuideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0);
    }];

    
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
    
    // Set Table View Constraints
    [self.guideTripsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentedControl.mas_bottom).with.offset(10);
        make.left.and.right.equalTo(self.profileView);
        NSUInteger numberOfCells = self.selectedGuideUser.allTrips.count;

        // hacky way to make table view longer
        NSNumber *cellHeight = @(320);
        NSNumber *tableViewHeight = @([cellHeight floatValue] * numberOfCells);
        make.height.equalTo(tableViewHeight);
        }];
    
    
    // Set Content View Constraints
    
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        //Add padding to bottom of VC
        make.bottom.equalTo(self.guideTripsTableView.mas_bottom).with.offset(10);
    }];
    
    }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return self.selectedGuideUser.allTrips.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
 TRVTouristTripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tripCell" forIndexPath:indexPath];
     
     NSMutableArray *allTripsForThisUser = self.selectedGuideUser.allTrips;
     NSLog(@"%@", allTripsForThisUser[indexPath.row]);
     // creating custom view of UITableView Cell
     TRVTourView *tourView = [[TRVTourView alloc] init];
     [cell addSubview:tourView];

     // set constraints for tour nib
     [tourView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(cell).with.offset(10);
         make.left.equalTo(cell).with.offset(5);
         make.right.equalTo(cell).with.offset(-5);
         make.bottom.equalTo(cell.mas_bottomMargin).with.offset(10);
     }];
     
     tourView.tourForThisTourView = allTripsForThisUser[indexPath.row];
     tourView.backgroundColor = [UIColor redColor];
     
     
//     self.guideTripsTableView.estimatedRowHeight = 300;
     
     return cell;
     
 }
 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 320;
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
