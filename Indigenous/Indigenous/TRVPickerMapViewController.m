//
//  TRVPickerMapViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//
/**
A is a delegate object of B.

B will have a reference of A.

A will implement the delegate methods of B.

B will notify A through the delegate methods.

 A = Add Tours
 B = Map (this one)
 
 */

//#import "TRVPickerMapLogic.h" //includes GMapsSDK
#import <INTULocationManager.h>
#import "INTULocationManager+CurrentLocation.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "TRVAddToursVC.h"
#import "TRVPickerMapViewController.h"


@interface TRVPickerMapViewController () <GMSMapViewDelegate>


@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, copy) NSSet *markers;

@end

@implementation TRVPickerMapViewController {
    GMSMarker *userSelection_;
}

//- (id)delegate {
//    return _delegate;
//}
//
//- (void)setDelegate:(id)newDelegate {
//    _delegate = newDelegate;
//}



- (void)viewDidLoad {
    [super viewDidLoad];

        //Immediately draws a map with the pre-loaded user location, carried over by the singleton locationManager from the TabBarVC...
    INTULocationManager *locationManager = [INTULocationManager sharedInstance];
    CLLocationCoordinate2D defaultLocation = locationManager.currentLocation.coordinate;
#pragma mark - MapView Initialization
        //Opens the map to the user's current location.
    GMSCameraPosition *defaultCamera       = [GMSCameraPosition cameraWithTarget:defaultLocation zoom:14];
    self.mapView                           = [GMSMapView mapWithFrame:self.view.bounds camera:defaultCamera];
    self.mapView.mapType                   = kGMSTypeNormal;
    self.mapView.myLocationEnabled         = YES;
    self.mapView.settings.compassButton    = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.mapView setMinZoom:10 maxZoom:18];
   
        //Codeschool said to add this line `[self.view addSubview:self.mapView];` but it turns out that broke the delegation.
    self.view = self.mapView;
    self.mapView.delegate = self;
    
    NSLog(@"CoreLocator says I'm here: %f, %f", defaultLocation.latitude, defaultLocation.longitude);
//    [self setupMarkerData];
    
        //Now follows up with a slow loading, highly accurate location.
//    __block GMSCameraPosition *updatedCamera;
    [locationManager requestLocationWithDesiredAccuracy:INTULocationAccuracyRoom timeout:10 delayUntilAuthorized:YES
                                                  block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                
                                                      [self.mapView animateWithCameraUpdate:[GMSCameraUpdate setTarget:currentLocation.coordinate zoom:15]];
                                                  }];
}
/**
 *  Marker1 = FIS
 *  Marker2 = Statue of Liberty
 *  Marker3 = Amitai's Apartment growing up on the UWS (Deprecated 😦; it was a rental)
 */
-(void)setupMarkerData {
//    INTULocationManager *locationManager = [INTULocationManager sharedInstance];
//    GMSMarker *marker1 = [GMSMarker markerWithPosition:locationManager.currentLocation.coordinate]
    GMSMarker *marker1 = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(40.70531680012648,-74.01396463558194)];
//    marker1.title = @"First marker!!";
//    marker1.snippet = @"First Snippet!";
//    marker1.appearAnimation = kGMSMarkerAnimationPop;
//    marker1.draggable = YES;
    marker1.map = nil;
    
    
    GMSMarker *marker2 = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(40.6892750, -74.0445560)];
    marker2.map = nil;
    
    GMSMarker *marker3 = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(40.7907300,-73.9723580)];
    marker3.map = nil;
    
    self.markers = [NSSet setWithObjects:marker1, marker2, marker3, nil];
    
    [self drawMarkers];
}

    //Only draw markers that are not already On...
-(void)drawMarkers {
    for (GMSMarker *marker in self.markers) {
        if (marker.map == nil) {
            marker.map = self.mapView;
        }
    }
}

//Probably not necessary any longer
//==================
//-(void)reportINTUstatus:(INTULocationStatus*)status fromMethod:(NSString *)methodName {
//    if (status == INTULocationStatusSuccess)         {
//        NSLog(@"SUCCESS in the INTULocation %@!", methodName);
//    } else if (status == INTULocationStatusTimedOut) {
//        NSLog(@"TIMED OUT in the INTULocation %@!", methodName);
//    } else if (status == INTULocationStatusError)    {
//        NSLog(@"ERROR in the INTULocation %@!", methodName);
//    } else {
//        NSLog(@"SOME STATUS in the INTULocation %@!", methodName);
//    }
//}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
        //This will ensure the compass and myLocation button are not covered up by the NavigationBar etc.
    self.mapView.padding = UIEdgeInsetsMake(self.topLayoutGuide.length    + 5, 0,
                                         self.bottomLayoutGuide.length + 5, 0);
}

#pragma mark GMSMapViewDelegate

#pragma mark - infoWindow Methods

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
        //infoWindow setup
    UIView *iWindow = [UIView new];
    iWindow.frame = CGRectMake(0, 0, 200, 70);
    iWindow.backgroundColor = [UIColor cyanColor];
    
        //titleLabel setup
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(14, 11, 175, 16); //(x & y anchors in the superview, width & height)
    [iWindow addSubview:titleLabel];
    titleLabel.text = marker.title;
    
        //snippet setup
    UILabel *snippetLabel = [UILabel new];
    snippetLabel.frame = CGRectMake(14, 42, 175, 16);
    [iWindow addSubview:snippetLabel];
    snippetLabel.text = marker.snippet;
    
        //custom background image style
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GMSSprites-0-1x"]];
//    [iWindow addSubview:backgroundImage];
    
    marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
    
    return iWindow;
}

#pragma mark - Events (delegate methods)

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    NSString *message = [NSString stringWithFormat:@"You tapped selected (%.4f, %.4f). Confirm selection?", marker.position.latitude, marker.position.longitude];
    
    UIAlertController *windowTappedAlert = [UIAlertController alertControllerWithTitle:@"Confirm Tour-Stop Selection"
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleActionSheet];
        //TODO: Add action items (confirm selection; cancel; reverse/geocode it for me)
    
    
    [self presentViewController:windowTappedAlert animated:YES completion:nil];
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f, %f", coordinate.latitude, coordinate.longitude);
}

-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
//    userSelection_ = [GMSMarker markerWithPosition:coordinate];
    CLLocation *userSelection = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self.delegate userSelectedTourStopLocation:userSelection];
}
/*
#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
}
*/
/**
✓⃞– mapView:markerInfoContents:
⃞– mapView:didTapInfoWindowOfMarker:
⃞✓–mapView:markerInfoWindow:
⃞– mapView:willMove:
⃞– mapView:didChangeCameraPosition:
⃞– mapView:idleAtCameraPosition:
⃞– mapView:didTapAtCoordinate:
⃞– mapView:didLongPressAtCoordinate:
⃞– mapView:didTapMarker:
⃞– mapView:didTapOverlay:
⃞– mapView:didBeginDraggingMarker:
⃞– mapView:didEndDraggingMarker:
⃞– mapView:didDragMarker:
⃞– didTapMyLocationButtonForMapView:
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
