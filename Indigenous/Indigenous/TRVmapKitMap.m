//
//  TRVmapKitMap.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/11/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVmapKitMap.h"

@interface TRVmapKitMap ()

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic) BOOL userLocationUpdated;


@end

@implementation TRVmapKitMap

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    [self centerMapOnNYC];
//    self.mapView.showsUserLocation = YES;
    if (self.userLocationUpdated != TRUE) {
        [self centerMapOnUserLocation];
    }

}


#pragma mark Setup Helpers

-(void)centerMapOnNYC {
    CLLocationCoordinate2D centerNYC  = CLLocationCoordinate2DMake(40.7053,-74.0139);

    CLLocationDistance regionWidth    = 1500;//in meters, mind you.
    CLLocationDistance regionHeight   = 1500;

    MKCoordinateRegion startNYCRegion = MKCoordinateRegionMakeWithDistance(centerNYC, regionWidth, regionHeight);
    [self.mapView setRegion:startNYCRegion animated:YES];
}

-(void)centerMapOnUserLocation {
    self.mapView.showsUserLocation = YES;
    if (self.mapView.userLocation.location.coordinate.latitude != (double)0)
        {
            [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate];
        } else {
            INTULocationManager *locationManager = [INTULocationManager sharedInstance];
            [locationManager requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock timeout:15 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                [self.mapView setCenterCoordinate:currentLocation.coordinate
                                         animated:YES];
                self.userLocationUpdated = YES;
            }];
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
