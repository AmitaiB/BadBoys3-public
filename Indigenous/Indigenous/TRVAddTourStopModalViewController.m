//
//  TRVAddTourStopModalViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/14/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//
#import "SCNumberKeyBoard.h"
#import "TRVAddTourStopModalViewController.h"

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVAddTourStopModalViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

//@property (weak, nonatomic) IBOutlet UISwitch *lngPlusMinusToggle;
//@property (weak, nonatomic) IBOutlet UISwitch *latPlusMinusToggle;
@property (weak, nonatomic) IBOutlet UITextField *latTxF;
@property (weak, nonatomic) IBOutlet UITextField *lngTxF;
@property (weak, nonatomic) IBOutlet UITextField *placeNameTxF;
@property (weak, nonatomic) IBOutlet UITextField *streetAddressTxF;
@property (weak, nonatomic) IBOutlet UITextField *cityTxF;
@property (weak, nonatomic) IBOutlet UITextField *stateTxF;
@property (weak, nonatomic) IBOutlet UITextField *postalCodeTxF;
@property (weak, nonatomic) IBOutlet UIButton *saveTourStopButton;
- (IBAction)saveTourStopButtonTapped:(id)sender;
- (IBAction)reverseGeoCodeButtonTapped:(id)sender;
- (IBAction)geoCodeButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reverseGeoCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *geoCodeButton;
- (IBAction)toggleCoordSign:(id)sender;
- (IBAction)toggleLngSign:(id)sender;


@end

@implementation TRVAddTourStopModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [SCNumberKeyBoard showWithTextField:self.latTxF block:^(UITextField *textField, NSString *number) {
                NSLog(@"textField!: %@\nnumber (NSString)!: %@", [textField description], number);
            }];
    [SCNumberKeyBoard showWithTextField:self.lngTxF block:^(UITextField *textField, NSString *number) {
                NSLog(@"textField!: %@\nnumber (NSString)!: %@", [textField description], number);
            }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.latTxF.text && self.lngTxF.text) {
        self.reverseGeoCodeButton.enabled = YES;
    }
    return YES;
}

#pragma mark - helper methods



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveTourStopButtonTapped:(id)sender {
}

- (IBAction)reverseGeoCodeButtonTapped:(id)sender {
}

- (IBAction)geoCodeButtonTapped:(id)sender {
}
/**
 *  stringLat → numLat → abs_value(numLat) → That x -1 → stringValue(That) = tada!
 *
 *  @param sender The UISwitch toggle...
 */
- (IBAction)toggleCoordSign:(UISwitch*)sender {
    switch (sender.tag) {
        case 1: //Latitude's toggle in IB
            self.latTxF.text = [NSString stringWithFormat:@"%@%@", (sender.state)? @"" : @"-", [@(labs([self.latTxF.text integerValue])) stringValue]];
            break;
        case 2: //Longitude's toggle in IB
            self.lngTxF.text = [NSString stringWithFormat:@"%@%@", (sender.state)? @"" : @"-", [@(labs([self.lngTxF.text integerValue])) stringValue]];
            break;
        default:
            DBLG
            break;
    }
}

@end
