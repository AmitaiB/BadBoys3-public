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
     
    CLLocationCoordinate2D defaultLocation = locationManager.currentLocation.coordinate;
    
        //Immediately draws a map with the pre-loaded user location, carried over by the singleton locationManager from the TabBarVC...
    GMSCameraPosition *defaultCamera = [GMSCameraPosition cameraWithTarget:defaultLocation zoom:16];
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:defaultCamera];
    self.mapView.myLocationEnabled = YES;
    [self.view addSubview:self.mapView];
    NSLog(@"CoreLocator says I'm here: %f, %f", defaultLocation.latitude, defaultLocation.longitude);
    __block GMSCameraPosition *camera;
    
        //Now follows up with a slow loading, highly accurate location.
//    __block GMSCameraPosition *updatedCamera;
    [locationManager requestLocationWithDesiredAccuracy:INTULocationAccuracyRoom timeout:10 delayUntilAuthorized:YES
                                                  block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                                      
                                                      /**
                                                       *  This method should work...
                                                       */
                                                      [self.mapView animateWithCameraUpdate:[GMSCameraUpdate setTarget:currentLocation.coordinate zoom:17]];
//                                                      updatedCamera = [GMSCameraPosition cameraWithTarget:currentLocation.coordinate zoom:17];
//                                                      self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:updatedCamera];
//                                                      self.mapView.myLocationEnabled = YES;
//                                                      [self.view addSubview:self.mapView];
//                                                      NSLog(@"CoreLocator says I'm here: %f, %f", updatedCamera.target.latitude, updatedCamera.target.longitude);
                                                  }];
        
}

-(void)reportINTUstatus:(INTULocationStatus*)status {
    
}

/**
 *  This may be unnecessary...
 */
-(void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
//  If the status is denied, or only granted for when in use, display an alert.
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title          = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location services are not enabled";
        NSString *message        = @"To use background location services, you must select 'Always' in Settings → Location Services.";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Uh, OK" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *goToSettingsAction = [UIAlertAction actionWithTitle:@"Take me to Settings! Schnell!!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:settingsURL];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
//  The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"would have called... [locationManager requestAlwaysAuthorization];");
    }
}
/**
 *  Ditto.
 *
 *  @param manager <#manager description#>
 *  @param status  <#status description#>
 */
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
        NSLog(@"would have called... [self.locationManager requestWhenInUseAuthorization];");
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
