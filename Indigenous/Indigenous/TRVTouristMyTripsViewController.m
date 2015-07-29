//
//  TRVTouristMyTripsViewController.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTouristMyTripsViewController.h"
#import "TRVTouristTripDataSource.h"
#import "TRVUser.h"

@interface TRVTouristMyTripsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tripTableView;
@property (nonatomic, strong) TRVTouristTripDataSource *tableViewDataSource;
@end

@implementation TRVTouristMyTripsViewController

- (NSArray*)pastTrips {
    NSPredicate *pastPred = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject compare:[NSDate date]] == NSOrderedAscending;
    }];
    return [self.tourist.myTrips filteredArrayUsingPredicate:pastPred];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewDataSource = [[TRVTouristTripDataSource alloc] init];
    
    self.tripTableView.dataSource = self.tableViewDataSource;
    //(__bridge id<UITableViewDataSource>)(CFRetain((__bridge CFTypeRef)([[TRVTouristTripDataSource alloc] init])));
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
