//
//  TRVPickerMapViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVPickerMapViewController.h"
#import "TRVPickerMapLogic.h" //includes GMapsSDK
#import "TRVCoreLocator.h"


@interface TRVPickerMapViewController ()

@property (nonatomic, strong) GMSMapView *mapView;

@end

@implementation TRVPickerMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  CLLocation → 2Dcoords → camera position → gMap
     */
    TRVCoreLocator *locator = [TRVCoreLocator new];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:[locator YouAreHere].coordinate zoom:18];
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds
                                     camera:camera];
    self.mapView.myLocationEnabled = YES;
    
    [self.view addSubview:self.mapView];
    
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
