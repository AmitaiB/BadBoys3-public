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
#import "UIScrollView+APParallaxHeader.h"
//#import "TRVTourStop.h"

@interface TRVTouristTripDetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navBarTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *tourStopCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *tourStopImageView;
@property (nonatomic, strong) TRVTourStopCollectionViewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIScrollView *theScrollViewThatHoldsAllTheOtherViews;
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
    self.theScrollViewThatHoldsAllTheOtherViews.delegate = self;
    //[self.theScrollViewThatHoldsAllTheOtherViews addParallaxWithImage:[UIImage imageNamed:@"Carmelo.jpg"] andHeight:160];
    //[self.theScrollViewThatHoldsAllTheOtherViews setContentOffset:CGPointMake(0, self.theScrollViewThatHoldsAllTheOtherViews.contentInset.top)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Carmelo.jpg"]];
    CGFloat width = self.theScrollViewThatHoldsAllTheOtherViews.bounds.size.width;
    [imageView setFrame:CGRectMake(0, 0, width, width/2)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedParrallaxImage)];
    [imageView addGestureRecognizer:tap];
    imageView.userInteractionEnabled = YES;
    [self.theScrollViewThatHoldsAllTheOtherViews addParallaxWithView:imageView andHeight:imageView.bounds.size.height];
    

    
    [self makeContentInsetFullScreen:self.theScrollViewThatHoldsAllTheOtherViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"%@", NSStringFromCGPoint(*targetContentOffset));
    if ((*targetContentOffset).y == -224)
        [self makeContentInsetFullScreen:scrollView];
}

- (void)makeContentInsetFullScreen:(UIScrollView *)scrollView {
    UIScreen *screen = [UIScreen mainScreen];
    UIEdgeInsets inset = scrollView.contentInset;
    inset.top = screen.bounds.size.height;
    scrollView.contentInset = inset;
}

- (void)tappedParrallaxImage {
    [UIView animateWithDuration:1 animations:^{
        CGFloat width = self.theScrollViewThatHoldsAllTheOtherViews.bounds.size.width;
        self.theScrollViewThatHoldsAllTheOtherViews.contentOffset = CGPointMake(0, -width/2);
    } completion:^(BOOL finished) {
        CGPoint offset = self.theScrollViewThatHoldsAllTheOtherViews.contentOffset;
        [self.theScrollViewThatHoldsAllTheOtherViews setContentOffset:offset animated:NO];
        //self.theScrollViewThatHoldsAllTheOtherViews.isDragging = NO;
    }];
    //self.theScrollViewThatHoldsAllTheOtherViews.contentOffset = CGPointMake(0, 0);
}

@end
