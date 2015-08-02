//
//  TRVSearchTripsViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUser.h"
#import "TRVBio.h"
#import "TRVSearchTripsViewController.h"
#import "TRVSearchResultsDataSource.h"
#import <Masonry/Masonry.h>


@interface TRVSearchTripsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (nonatomic, strong) TRVSearchResultsDataSource *resultsDataSource;



@end

@implementation TRVSearchTripsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set datasource file
    self.resultsDataSource = [[TRVSearchResultsDataSource alloc] init];
    self.resultsTableView.dataSource = self.resultsDataSource;
    // Do any additional setup after loading the view.
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
