//
//  TRVmapKitMap.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/11/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVmapKitMap.h"

#define AVG(A,B) (A+B)/2


static NSString *const kTRVMapAnnotationIdentifier     = @"kTRVMapAnnotationIdentifier";
static NSString *const kTRVSearchResultsCellIdentifier = @"kTRVSearchResultsCellIdentifier";


@interface TRVmapKitMap ()

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UIView *searchBarPlaceholder;
@property (nonatomic, strong) NSArray *mapLocations;
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
    
    HNKGooglePlacesAutocompleteQuery *searchQuery = [HNKGooglePlacesAutocompleteQuery sharedQuery];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil]; //nil for now, but I could see a Searchresults controller being helpful.
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    self.searchBarPlaceholder = self.searchController.searchBar;
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.searchBarPlaceholder];
    [self.searchController.searchBar sizeToFit];
//    self.searchController.active = YES;
//    self.view = self.searchController.searchBar;
    self.definesPresentationContext = YES;

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

    //Need to reset the region to a box that will contain all your annotations...
-(void)addAndCenterOnLocations:(NSArray *)locations {
        //annotations have already been added here
        //declare the far corners of the world...of annotations:
    CLLocationDegrees minLat = 0;
    CLLocationDegrees minLng = 0;
    CLLocationDegrees maxLat = 0;
    CLLocationDegrees maxLng = 0;
    
        //choose the extremes of lat and long...
    for (CLLocation *location in locations) {
        minLat = MIN(minLat, location.coordinate.latitude);
        minLng = MIN(minLng, location.coordinate.longitude);
        maxLat = MAX(maxLat, location.coordinate.latitude);
        maxLng = MAX(maxLng, location.coordinate.longitude);
    }
    
    CLLocation *centerPoint = [[CLLocation alloc] initWithLatitude:AVG(minLat, maxLat)
                                                  longitude:AVG(minLng, maxLng)];
        //...to obtain the center.
    CLLocationCoordinate2D annotationsCenter = centerPoint.coordinate;
    
        //Determine how big your map must be to display them all.
    MKCoordinateSpan annotationsSpan = MKCoordinateSpanMake(ABS(maxLat - minLat),
                                                          ABS(maxLng - minLng));
    
    MKCoordinateRegion region = MKCoordinateRegionMake(annotationsCenter, annotationsSpan);
    
        //With all that as preparation, set the map to the new region.
    [self.mapView setRegion:region];
}


#pragma mark MapView Delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil; //because we want our pulsing blue dot!
    }
    MKAnnotationView *view = [self.mapView dequeueReusableAnnotationViewWithIdentifier:kTRVMapAnnotationIdentifier];
    
    if (!view) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kTRVMapAnnotationIdentifier];
    }
    
    return view;
    
    
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

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}

@end
