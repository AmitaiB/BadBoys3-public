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
#import <Masonry/Masonry.h>


@interface TRVSearchTripsTableViewController ()

@property (nonatomic, strong) TRVSearchResultsDataSource *resultsDataSource;


@end

@implementation TRVSearchTripsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set datasource file
    self.resultsDataSource = [[TRVSearchResultsDataSource alloc] init];
    self.tableView.dataSource = self.resultsDataSource;

}



@end
