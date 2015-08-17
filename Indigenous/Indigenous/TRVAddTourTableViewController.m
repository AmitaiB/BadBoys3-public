//
//  TRVAddTourTableViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/15/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <CZPicker.h>
#import "TRVAddTourTableViewController.h"
#import "SBFlatDatePicker.h"
#import <SCLAlertView.h>


#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVAddTourTableViewController ()

typedef NS_ENUM(NSUInteger, TRVTourDataRow) {
    TRVTourNameRow,
    TRVTourGuideRow,
    TRVTourCategoryRow,
    TRVTourDateRow,
    TRVTourItineraryRow
};

typedef NS_ENUM(NSUInteger, TRVTableViewSectionType) {
    TRVStaticDataSection,
    TRVMutableItinerarySection
};

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
    NSLog(@"You tapped %@", self.tourCategories[row]);
    self.tourData.tourCategory.tourCategoryType = (TRVTourCategoryType)row; //Very hacky, I don't like it.
    NSLog(@"tourCategoryType...: %@", [self.tourData.tourCategory description]);
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

#pragma mark - Confirm GuideName methods
-(void)confirmGuideName {
    SCLAlertView *alert = [[SCLAlertView alloc]initWithNewWindow];
    
    UITextField *textField = [alert addTextField:@"Enter Guide Name"];
    textField.delegate = self;
    
    [alert addButton:@"Edit Guide Name" target:self selector:nil];
    
    [alert showEdit:self title:@"Edit Guide Name" subTitle:@"Please enter the Guide's name or identifier" closeButtonTitle:@"shrug" duration:0.0f];
    
    
        //Construct URL to sound file
//    NSString *path = [NSString stringWithFormat:@"Indigenous/Bell%20Transition.mp3", [[NSBundle mainBundle]resourcePath]];
//    alert.soundURL = [NSURL URLWithString:path];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.tourData.tourGuide = textField.text;
    NSLog(@"The new tour Guide name is %@", self.tourData.tourGuide);
    return YES;
}

    //https://github.com/SolomonBier/SBFlatDatePicker
#pragma mark - SBFlatDatePicker delegate
-(void)sbPickDepartureDate {
    UIViewController *pickerViewController = [UIViewController new];
    SBFlatDatePicker *datePicker = [[SBFlatDatePicker alloc] initWithFrame:self.view.bounds];
    [datePicker.minuterange addIndex:0];
    [datePicker.minuterange addIndex:20];
    [datePicker.minuterange addIndex:40];
//    Customize Day Format
//    datePicker.dayFormat = @"EEE MMM dd";
    datePicker.delegate = self;
    pickerViewController.view = datePicker;
    [self presentViewController:pickerViewController animated:YES completion:^{
        DBLG
    }];
}

-(void)flatDatePicker:(SBFlatDatePicker *)datePicker saveDate:(NSDate *)date {
    DBLG
    NSLog(@"Saving Date: %@", date);
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if (section == TRVStaticDataSection) {
        return self.tourDataSubtitlesArray.count;
    }
    if (section == TRVMutableItinerarySection) {
        return self.tourData.tourStopGeoPoints.count + 1;
    }
    else return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID forIndexPath:indexPath];
    
    if (indexPath.section == TRVStaticDataSection) {
        cell.detailTextLabel.text = self.tourDataSubtitlesArray[indexPath.row];
        cell.textLabel.text = self.tourDataWithUserInputTitlesArray[indexPath.row];
    }
    if (indexPath.section == TRVMutableItinerarySection) {
        cell.textLabel.text = self.tourData.tourStopGeoPoints[indexPath.row];
        cell.detailTextLabel.text = @"Reverse Geocode me";
    }
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TRVTourDataRow x = indexPath.row;
    switch (x) {
        case TRVTourNameRow: {
            DBLG
            break;
        }
        case TRVTourGuideRow: {
            [self confirmGuideName];
            break;
        }
        case TRVTourCategoryRow: {
            [self czPickTourCategory];
            break;
        }
        case TRVTourDateRow: {
            [self sbPickDepartureDate];
            break;
        }
//        case TRVTourItineraryRow: {
//            [self performSegueWithIdentifier:/*MAP!!*/ sender:self];
//            break;
//        }
        default: {
            [self performSegueWithIdentifier:toEditAllSegueID sender:self];
            break;
        }
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
    
    self.tourDataWithUserInputTitlesArray = [self.tourDataDefaultTitlesArray mutableCopy];

    NSLog(@"self.tourDataWithUserInputTitlesArray: %@, of size: %@", [self.tourDataWithUserInputTitlesArray description], @(self.tourDataWithUserInputTitlesArray.count));
    NSLog(@"The original article: %@ of size %@", [[self.tourData allValues] description], @([self.tourData allValues].count));
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
