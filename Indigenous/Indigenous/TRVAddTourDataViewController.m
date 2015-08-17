//
//  TRVAddTourDataViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVAddTourDataViewController.h"
#import "TRVTourDataPF.h"

@interface TRVAddTourDataViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tourNameTxF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tourCategorySegControl;
@property (weak, nonatomic) IBOutlet UIButton *departureDateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIImageView *tourImageView;

@property (strong, nonatomic) TRVTourDataPF *tourData;

@end

@implementation TRVAddTourDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tourData = [TRVTourDataPF new];
    
    
    // Do any additional setup after loading the view.
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
