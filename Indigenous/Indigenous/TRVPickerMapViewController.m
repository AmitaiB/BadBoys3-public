//
//  TRVPickerMapViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

//#define requestWhateverAuthorization requestAlwaysAuthorization
//#define requestWhateverAuthorization requestWhenInUseAuthorization

#import "TRVPickerMapViewController.h"
#import "TRVPickerMapLogic.h" //includes GMapsSDK
#import <INTULocationManager.h>
#import "INTULocationManager+CurrentLocation.h"

@interface TRVPickerMapViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) GMSMapView *mapView;

@end

@implementation TRVPickerMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    INTULocationManager *locationManager = [INTULocationManager sharedInstance];
    /**
     *  CLLocation → 2Dcoords → camera position → gMap
     */
    
    
    
//    [self safeRequestForWhenInUseAuth];
//    [self.locationManager startMonitoringSignificantLocationChanges];
    
    CLLocationCoordinate2D mostRecentLoc = self.locationManager.location.coordinate;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:mostRecentLoc zoom:18];
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    self.mapView.myLocationEnabled = YES;
    
    CLLocationCoordinate2D defaultLocation = locationManager.currentLocation.coordinate;
    
        //Immediately draws a map with the pre-loaded user location, carried over by the singleton locationManager from the TabBarVC...
    GMSCameraPosition *defaultCamera = [GMSCameraPosition cameraWithTarget:defaultLocation zoom:16];
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:defaultCamera];
    self.mapView.myLocationEnabled = YES;
    [self.view addSubview:self.mapView];
    NSLog(@"CoreLocator says I'm here: %f, %f", mostRecentLoc.latitude, mostRecentLoc.longitude);
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusDenied ||
        status == kCLAuthorizationStatusRestricted ||
        status == kCLAuthorizationStatusNotDetermined) {

            NSString *title;
            
            title = (status == kCLAuthorizationStatusDenied ||
                     status == kCLAuthorizationStatusRestricted)? @"Location Services Are Off" : @"Background use is not enabled";
            
            NSString *message = @"Go to settings";
            
            UIAlertController *settingsAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *goToSettings = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction *action) {
                                                                     NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                               [[UIApplication sharedApplication]openURL:settingsURL];
                                           }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            
            [settingsAlert addAction:goToSettings];
            [settingsAlert addAction:cancel];
            [self presentViewController:settingsAlert animated:YES completion:nil];
        
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
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
