//
//  TRVTouristTripDetailViewController.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTouristTripDetailViewController.h"
#import "TRVTour.h"
#import "TRVTourStopCollectionViewDataSource.h"
#import "TRVTourStopCollectionViewDelegateFlowLayout.h"
//#import "TRVTourStop.h"

@interface TRVTouristTripDetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navBarTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *tourStopCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *tourStopImageView;
@property (nonatomic, strong) TRVTourStopCollectionViewDataSource *dataSource;
@property (nonatomic, strong) TRVTourStopCollectionViewDelegateFlowLayout *collectionViewDelegate;
@end

@implementation TRVTouristTripDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitle.title = self.tour.tourItinerary.name;
    
    self.dataSource = [[TRVTourStopCollectionViewDataSource alloc] initWithStops:nil configuration:^(TRVTourStop * stop) {
        //self.tourStopImageView.image = stop.image;     stops do not yet have images
    }];
    self.tourStopCollectionView.dataSource = self.dataSource;
    self.collectionViewDelegate = [[TRVTourStopCollectionViewDelegateFlowLayout alloc] init];
    self.tourStopCollectionView.delegate = self.collectionViewDelegate;
    self.tourStopCollectionView.scrollsToTop = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
