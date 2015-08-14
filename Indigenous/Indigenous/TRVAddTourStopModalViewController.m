//
//  TRVAddTourStopModalViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/14/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVAddTourStopModalViewController.h"

@interface TRVAddTourStopModalViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

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


@end

@implementation TRVAddTourStopModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)saveTourStopButtonTapped:(id)sender {
}

- (IBAction)reverseGeoCodeButtonTapped:(id)sender {
}

- (IBAction)geoCodeButtonTapped:(id)sender {
}
@end
