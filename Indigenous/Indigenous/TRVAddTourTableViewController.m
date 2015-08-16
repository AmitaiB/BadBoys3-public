//
//  TRVAddTourTableViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/15/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVAddTourTableViewController.h"
#import "TRVEditTourNameViewController.h"
#import <UITableViewCell+FlatUI.h>
#import <UIColor+FlatUI.h>

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


static NSString *cellID = @"cellID";
static NSString *FUITableViewControllerCellReuseIdentifier = @"FUITableViewControllerCellReuseIdentifier";
static NSString *toEditTourNameSegueID = @"toEditTourNameSegueID";

NS_ENUM(NSUInteger, TRVTourDetailType) {
    TRVtourNameDetailType,
    TRVtourGuideDetailType,
    TRVTourCategoryDetailType,
    TRVtourDateDetailType,
    TRVtourItineraryDetailType
};


@interface TRVAddTourTableViewController ()

@end

@implementation TRVAddTourTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.defaultTourCellDetailTitles = @[@"Tour Name", @"Guide", @"Theme/Category", @"Departure Date", @"Itinerary"];
    self.defaultTourCellTitles = @[@"Name Your Tour",
                                   @"Confirm Guide",
                                   @"Select Theme/Category",
                                   @"Choose Date",
                                   @"Build Itinerary"];
#pragma mark - FlatUIKit example part 1
    self.title = @"Table View";
    
        //Set the separator color
    self.tableView.separatorColor = [UIColor cloudsColor];
    
        //Set the background color
    self.tableView.backgroundColor = [UIColor cloudsColor];
    self.tableView.backgroundView = nil;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FUITableViewControllerCellReuseIdentifier];
    
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
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return self.defaultTourCellDetailTitles.count;
    }
    if (section == 1) {
        return 1;
    }
    
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *flatCell = [tableView dequeueReusableCellWithIdentifier:FUITableViewControllerCellReuseIdentifier];
//    UIRectCorner corners = 0;
//    [flatCell configureFlatCellWithColor:[UIColor greenSeaColor]
//                           selectedColor:[UIColor cloudsColor]
//                         roundingCorners:corners];
//    
//    flatCell.cornerRadius = 5.f; //optional
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = self.defaultTourCellTitles[indexPath.row];
            cell.detailTextLabel.text = self.defaultTourCellDetailTitles[indexPath.row];
//            flatCell.textLabel.text = self.defaultTourCellTitles[indexPath.row];
//            flatCell.detailTextLabel.text = self.defaultTourCellDetailTitles[indexPath.row];
            break;
        case 1:
            
        default:
            break;
    }
    
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:toEditTourNameSegueID sender:self];
    }
    
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:toEditTourNameSegueID]) {
        TRVEditTourNameViewController *destinationVC = segue.destinationViewController;
        destinationVC.editTourNameTxF.delegate = self;
    }
    
}


@end
