//
//  TRVTourGuideFlowRootTableViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/16/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourGuideFlowRootTableViewController.h"

#import <Parse.h>
#import <ParseUI.h>
#import "TRVLocalTourData_PF.h"

/**
 import all linked view controllers here.
 */
#import "TRVEditTourNameViewController.h"
    //There will be others...!!!

    //A private debugging convenience macro.
#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));
    //local datastore pin:
#define localDataStorePinName @"localDataStorePinName"

typedef NS_ENUM(uint8_t, TRVViewControllerType) {
    PFEditTourNameVC
};

@interface TRVTourGuideFlowRootTableViewController ()
{
    NSArray *_tourCellDetailTitles;
    NSArray *_defaultTourCellTitles;
    TRVLocalTourData_PF *_localTourFromDatastore;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_DESIGNATED_INITIALIZER;

@end

@implementation TRVTourGuideFlowRootTableViewController

#pragma mark -
#pragma mark Init

-(instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}

-(instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) return nil;
    
    self.title = @"Populate Tour Data with Parse";
    _tourCellDetailTitles = @[@"Tour Name",
                              @"Guide",
                              @"Theme/Category",
                              @"Departure Date",
                              @"Itinerary"];
    _defaultTourCellTitles = @[@"Name Your Tour",
                               @"Confirm Guide",
                               @"Select Theme/Category",
                               @"Choose Date",
                               @"Build Itinerary"];
    
    PFQuery *localTourDataQuery = [PFQuery queryWithClassName:NSStringFromClass([TRVLocalTourData_PF class])];
    [localTourDataQuery fromPinWithName:localDataStorePinName];
    NSError *error;
    _localTourFromDatastore = [localTourDataQuery getFirstObject:&error];
    if (error) {
        NSLog(@"Error fetching localTourFromDataStore: %@", error.localizedDescription);
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self init];
}

#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_localTourFromDatastore.tourStopCoordinatesArray.count > 0) {
        return 2;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return _tourCellDetailTitles.count;
    }
    if (section == 2) {
        return _localTourFromDatastore.tourStopCoordinatesArray.count;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
