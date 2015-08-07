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
#import <GoogleMaps/GoogleMaps.h>

@interface TRVPickerMapViewController () <CLLocationManagerDelegate, GMSMapViewDelegate>

@property (nonatomic, strong) GMSMapView *mapView;
//@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation TRVPickerMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    INTULocationManager *locationManager = [INTULocationManager sharedInstance];    
    CLLocationCoordinate2D defaultLocation = locationManager.currentLocation.coordinate;
    
        //Immediately draws a map with the pre-loaded user location, carried over by the singleton locationManager from the TabBarVC...

#pragma mark - MapView Initialization

        //Opens the map to the user's current location.
    GMSCameraPosition *defaultCamera       = [GMSCameraPosition cameraWithTarget:defaultLocation zoom:14];
    self.mapView                           = [GMSMapView mapWithFrame:self.view.bounds camera:defaultCamera];
    self.mapView.mapType                   = kGMSTypeNormal;
    self.mapView.myLocationEnabled         = YES;
    self.mapView.settings.compassButton    = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.mapView setMinZoom:10 maxZoom:18];
    [self.view addSubview:self.mapView];
    NSLog(@"CoreLocator says I'm here: %f, %f", defaultLocation.latitude, defaultLocation.longitude);
    
        //Now follows up with a slow loading, highly accurate location.
//    __block GMSCameraPosition *updatedCamera;
    [locationManager requestLocationWithDesiredAccuracy:INTULocationAccuracyRoom timeout:10 delayUntilAuthorized:YES
                                                  block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                
                                                      [self.mapView animateWithCameraUpdate:[GMSCameraUpdate setTarget:currentLocation.coordinate zoom:15]];
                                                      [self setupMarkerData];
                                                  }];
}

-(void)setupMarkerData {
//    INTULocationManager *locationManager = [INTULocationManager sharedInstance];
//    GMSMarker *marker1 = [GMSMarker markerWithPosition:locationManager.currentLocation.coordinate]
    GMSMarker *marker1 = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(40.70531680012648,-74.01396463558194)];
    marker1.title = @"First marker!!";
    marker1.snippet = @"First Snippet!";
    marker1.appearAnimation = kGMSMarkerAnimationPop;
    marker1.map = self.mapView;
    marker1.draggable = YES;
}


-(void)reportINTUstatus:(INTULocationStatus*)status fromMethod:(NSString *)methodName {
    if (status == INTULocationStatusSuccess)         {
        NSLog(@"SUCCESS in the INTULocation %@!", methodName);
    } else if (status == INTULocationStatusTimedOut) {
        NSLog(@"TIMED OUT in the INTULocation %@!", methodName);
    } else if (status == INTULocationStatusError)    {
        NSLog(@"ERROR in the INTULocation %@!", methodName);
    } else {
        NSLog(@"SOME STATUS in the INTULocation %@!", methodName);
    }
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.mapView.padding = UIEdgeInsetsMake(self.topLayoutGuide.length + 5,
                                            0,
                                            self.bottomLayoutGuide.length + 5,
                                            0);
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
