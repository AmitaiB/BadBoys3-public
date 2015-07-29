//
//  TRVTouristTripDataSource.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTouristTripDataSource.h"
#import <UIKit/UIKit.h>

@interface TRVTouristTripDataSource () <UITableViewDataSource>

@property (nonatomic, weak) NSArray *trips;
@property (nonatomic, copy) void (^configureCell)();

@end

@implementation TRVTouristTripDataSource

-(instancetype)initWithTrips:(NSArray *)trips configuration:(void (^)())configureCell {
    if (self = [super init]) {
        _trips = trips;
        _configureCell = configureCell;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 0;//items.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    //id cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
    //                                          forIndexPath:indexPath];
    //id item = [self itemAtIndexPath:indexPath];
    //configureCellBlock(cell,item);
    return nil;//cell;
}

@end
