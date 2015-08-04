//
//  TRVFilterViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVFilterViewController.h"
#import "TRVUserDataStore.h"

@interface TRVFilterViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pricePicker;
@property (nonatomic, strong) NSArray *prices;

@property (nonatomic, strong) NSString *priceFilter;
@property (nonatomic, strong) NSString *subCategoryFilter;
@property (nonatomic, strong) NSDictionary *filterChoices;

@property (nonatomic, strong) TRVUserDataStore *dataStore;
@end

@implementation TRVFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    [self setUpPickerView];
    [self setUpSubCategories];
}


-(void)setUpPickerView {
    
    self.prices = @[@"$0 - $25", @"$26 - $50", @"$50 - $100"];
    self.pricePicker.dataSource = self;
    self.pricePicker.delegate = self;
    
    NSInteger row = [self.pricePicker selectedRowInComponent:0];
    self.priceFilter = self.prices[row];

    
}

-(void)setUpSubCategories {
    
    NSLog(@"Category: %@", self.dataStore.currentCategorySearching);
    
    if ([self.dataStore.currentCategorySearching isEqualToString:@"Eat"]){
        
        
        
        
    } else if ([self.dataStore.currentCategorySearching isEqualToString:@"Drink"]){
       
        
        
        
    } else if ([self.dataStore.currentCategorySearching isEqualToString:@"Play"]){
        
        
        
        
    } else if ([self.dataStore.currentCategorySearching isEqualToString:@"See"]){
        
        
    }
    
    
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.prices.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.prices[row];
}



// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.priceFilter = self.prices[row];
}





- (IBAction)doneButtonPressed:(id)sender {
    
    
    self.filterChoices = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.priceFilter,@"price",
                          self.subCategoryFilter, @"subCategory",
                          nil];
    
    
}





- (IBAction)dismissButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
