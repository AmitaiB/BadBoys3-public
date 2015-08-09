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
#import "TRVTour.h"
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

@property (nonatomic, strong) NSMutableArray *toursOfSelectedCategory;
@property (nonatomic, strong) NSMutableArray *otherTours;
@property (nonatomic) BOOL categoryTab;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@end

@implementation TRVDetailGuideAllTripsDataSource

-(instancetype)initWithTrips:(NSArray*)allTours {
    self = [super init];
    
    if (self) {
        _allTours = allTours;
        _sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
        // sets tab as results with category specified
        _categoryTab = YES;
    }
    return self;
}


#pragma mark - Table View Delegate Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//     Return the number of rows in the section.
    
    
    
    if (_categoryTab) {
        NSLog(@"NUMBER OF TOURS IN CATEGORY ARRAY!  %lu",(unsigned long)self.toursOfSelectedCategory.count);
        NSLog(@"NUMBER OF TOURS IN CATEGORY ARRAY!  %lu",(unsigned long)self.allTours.count);
        return self.toursOfSelectedCategory.count;
    }
    NSLog(@"NUMBER OF TOURS IN THIS OTHER TOURS ARRAY! %lu",(unsigned long)self.otherTours.count);
    return self.otherTours.count;
    
    return self.allTours.count;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"ARE YOU IN THIS CELL FOR ROW??");
//
//    TRVTour *tourForCell = nil;
//    [self filterTripsByCategory];
//    
//    if(_categoryTab) {
//    tourForCell = _toursOfSelectedCategory[indexPath.row];
//    }
//        tourForCell = _otherTours[indexPath.row];
    
    NSMutableArray *allTripsForThisUser = [self.allTours mutableCopy];;
    NSLog(@"%@", allTripsForThisUser[indexPath.row]);
    
    
    // creating custom view of UITableView Cell
    TRVTourView *tourView = [[TRVTourView alloc] init];
    TRVTouristTripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tripCell" forIndexPath:indexPath];
    NSLog(@"ARE YOU IN THIS CELL FOR ROW??");

    [cell addSubview:tourView];
    // set constraints for tour nib
    [tourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell).with.offset(10);
        make.left.equalTo(cell).with.offset(5);
        make.right.equalTo(cell).with.offset(-5);
        make.bottom.equalTo(cell.mas_bottomMargin).with.offset(10);
    }];
    
    tourView.tourForThisTourView = allTripsForThisUser[indexPath.row];
    
//    tourView.tourForThisTourView = tourForCell;

    tourView.backgroundColor = [UIColor redColor];
    
    //     self.guideTripsTableView.estimatedRowHeight = 300;
    
//    cell.tour = tourForCell;
    return cell;
    
}

- (void) changeTripsDisplayed {
    _categoryTab = !_categoryTab;
}

-(void)filterTripsByCategory {
    self.toursOfSelectedCategory = [[NSMutableArray alloc] init];
    self.otherTours = [[NSMutableArray alloc] init];
    
    for (TRVTour *tour in self.allTours) {
        NSLog(@"ARE YOU IN THIS FOR LOOP?");
//        if (tour.categoryForThisTour == self.sharedDataStore.currentCategorySearching) {
            [self.toursOfSelectedCategory addObject:tour];
//        } else{
//            [self.otherTours addObject:tour];
//        }
    }
}


@end
