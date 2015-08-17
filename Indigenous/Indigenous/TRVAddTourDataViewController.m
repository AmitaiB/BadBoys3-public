//
//  TRVAddTourDataViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//
#import "TRVBuildItineraryViewController.h"
#import "TRVTourImagePicker.h"
#import "TRVAddTourDataViewController.h"
#import "TRVTourData.h"
#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVAddTourDataViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tourNameTxF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tourCategorySegControl;
@property (weak, nonatomic) IBOutlet UIButton *departureDateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@property (strong, nonatomic) TRVTourData *tourData;
- (IBAction)dateButtonTapped:(id)sender;
- (IBAction)imageButtonTapped:(id)sender;

@end

@implementation TRVAddTourDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tourData = [TRVTourData new];
    [self initializeSegmentedControl];
    [self initializeDatePicker];
    // Do any additional setup after loading the view.
    
    [PFUser enableAutomaticUser];
}

#pragma mark - ImageView and ImagePicker methods




#pragma mark - Date (UIButton) and UIDatePicker methods

- (IBAction)dateButtonTapped:(id)sender {
    DBLG
    NSLog(@"DateButton doesn't do anything yet");
}

- (IBAction)imageButtonTapped:(id)sender {
}

-(void)initializeDatePicker {
    [self.datePicker addTarget:self action:@selector(assignTourDate) forControlEvents:UIControlEventValueChanged];
}

-(void)assignTourDate {
    self.tourData.tourDate = self.datePicker.date;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    self.dateButton.titleLabel.text = [dateFormatter stringFromDate:self.tourData.tourDate];
    NSLog(@"Tour Date set to: %@", [dateFormatter stringFromDate:self.tourData.tourDate]);
}


#pragma mark - UISegmentedControl methods

-(void)initializeSegmentedControl {
    [self.tourCategorySegControl setSelectedSegmentIndex:-1];
    [self.tourCategorySegControl addTarget:self action:@selector(assignTourCategory) forControlEvents:UIControlEventValueChanged];
}

-(void)assignTourCategory {
    NSString *categoryChosenViaSegmentedControl = self.tourData.tourCategories[self.tourCategorySegControl.selectedSegmentIndex];
    self.tourData.tourCategory = categoryChosenViaSegmentedControl;
    NSLog(@"TourCategory set to: %@", self.tourData.tourCategory);
}

#pragma mark - UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.tourData.tourName = textField.text;
    NSLog(@"TourName set to: %@", self.tourData.tourName);
    return YES;
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
