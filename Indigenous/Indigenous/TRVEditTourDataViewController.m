//
//  TRVEditTourDataViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/16/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//
#import <CZPicker.h>
#import "TRVEditTourDataViewController.h"

@interface TRVEditTourDataViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *tourCategorySegmentedControl;
- (IBAction)segmentedControlButtonTapped:(id)sender;

@end

@implementation TRVEditTourDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tourCategories = @[@"See", @"Play", @"Eat", @"Drink"];
    self.tourCategorySegmentedControl.selectedSegmentIndex = -1;
        //Initialize the segmented control's segments, and wire it up.
//    [self.tourCategorySegmentedControl addTarget:self
//                                          action:@selector(czPickTourCategory)
//                                forControlEvents:UIControlEventValueChanged];
//    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)czPickTourCategory{
    CZPickerView *categoryPicker = [[CZPickerView alloc] initWithHeaderTitle:@"Tour Category/Theme"
                                                           cancelButtonTitle:@"Cancel"
                                                          confirmButtonTitle:@"Confirm"];
    categoryPicker.delegate = self;
    categoryPicker.dataSource = self;
    [categoryPicker show];
}

#pragma mark - CZPicker delegate and datasource

-(NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    return self.tourCategories.count;
}

-(NSString *)czpickerView:(CZPickerView *)pickerView titleForRow:(NSInteger)row {
    
    return self.tourCategories[row];
}

-(void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    [self.tourCategorySegmentedControl setSelectedSegmentIndex:row];
}

-(void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)segmentedControlButtonTapped:(id)sender {
    [self czPickTourCategory];
}
@end
