//
//  TRVAddTourTableViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/15/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <CZPicker.h>
#import "TRVAddTourTableViewController.h"

@interface TRVAddTourTableViewController ()


@end

@implementation TRVAddTourTableViewController

static NSString * const toEditAllSegueID = @"toEditAllSegueID";
static NSString * const cellReuseID = @"cellReuseID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initizalizeViewControllerArrays];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - CZPicker datasource and delegate
-(NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    return self.tourCategories.count;
}

-(NSString *)czpickerView:(CZPickerView *)pickerView titleForRow:(NSInteger)row {
    return self.tourCategories[row];
}

-(void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    NSLog(@"You tapped row #%ld!", (long)row);
}

-(void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView {
    
}

-(void)czPickTourCategory{
    CZPickerView *categoryPicker = [[CZPickerView alloc] initWithHeaderTitle:@"Tour Category/Theme"
                                                           cancelButtonTitle:@"Cancel"
                                                          confirmButtonTitle:@"Confirm"];
    categoryPicker.delegate = self;
    categoryPicker.dataSource = self;
    [categoryPicker show];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (self.tourData.tourStopGeoPoints.count > 0) {
        return 2;
    } else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return self.tourDataSubtitlesArray.count;
    }
    if (section == 1) {
        return self.tourData.tourStopGeoPoints.count + 1;
    }
    else return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.detailTextLabel.text = self.tourDataSubtitlesArray[indexPath.row];
        cell.textLabel.text = self.tourDataWithUserInputTitlesArray[indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = self.tourData.tourStopGeoPoints[indexPath.row];
        cell.detailTextLabel.text = @"Reverse Geocode me";
    }
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:toEditAllSegueID sender:self];
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

#pragma mark - Helper methods
-(void)initizalizeViewControllerArrays {
    self.tourDataSubtitlesArray = @[@"Tour Name",
                                    @"Tour Guide",
                                    @"Category/Theme",
                                    @"Departure Date",
                                    @"Itinerary"];
    self.tourDataDefaultTitlesArray = @[@"Your Awesome Tour!",
                                        @"Are you the sherpa?",
                                        @"Save Me from The Paradox of Choice!",
                                        @"Are we there yet? Clearly not.",
                                        @"Where are we going?"];
    self.tourCategories = @[@"See", @"Play", @"Eat", @"Drink"];
    
    self.tourDataWithUserInputTitlesArray = [[self.tourData allValues] mutableCopy];

    NSLog(@"self.tourDataWithUserInputTitlesArray: %@, of size: %@", [self.tourDataWithUserInputTitlesArray description], @(self.tourDataWithUserInputTitlesArray.count));
    NSLog(@"The original article: %@ of size %@", [[self.tourData allValues] description], @([self.tourData allValues].count));

}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
