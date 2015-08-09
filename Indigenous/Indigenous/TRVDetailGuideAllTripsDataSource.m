//
//  TRVDetailGuideAllTripsDataSource.m
//  Indigenous
//
//  Created by Leo Kwan on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVDetailGuideAllTripsDataSource.h"

#import "TRVDetailGuideViewController.h"

#import "TRVDetailGuideAllTripsDataSource.h"

#import "TRVUserDataStore.h"
#import "TRVTouristTripTableViewCell.h"
#import "NSMutableArray+extraMethods.h"
#import "TRVUser.h"
#import "TRVTourStop.h"

// COCOAPODS
#import <Masonry.h>

// NIBS
#import "TRVUserSnippetView.h"
#import "TRVTourView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import "TRVUserProfileImageView.h"



@interface TRVDetailGuideAllTripsDataSource()

@property (nonatomic, weak) NSArray *allTours;

@end

@implementation TRVDetailGuideAllTripsDataSource

-(instancetype)initWithTrips:(NSArray*)allTours {
    self = [super init];
    
    if (self) {
        _allTours = allTours;
    }
    return self;
}


#pragma mark - Table View Delegate Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"%lu", self.allTours.count);
    return self.allTours.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TRVTouristTripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tripCell" forIndexPath:indexPath];
    
    NSMutableArray *allTripsForThisUser = [self.allTours mutableCopy];;
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


- (void) changeTripsDisplayed {


}


@end
