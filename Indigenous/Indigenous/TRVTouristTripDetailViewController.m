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
#import "TRVParallaxHeaderImageView.h"
//#import "TRVTourStop.h"

#import "Masonry/Masonry.h"

@interface TRVTouristTripDetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navBarTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *tourStopCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *tourStopImageView;
@property (nonatomic, strong) TRVTourStopCollectionViewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIScrollView *theScrollViewThatHoldsAllTheOtherViews;
@property (nonatomic, strong) TRVTourStopCollectionViewDelegateFlowLayout *collectionViewDelegate;
@property (nonatomic, strong) UILabel *parallaxHeaderTourNameLabel;
@end

@implementation TRVTouristTripDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitle.title = self.tour.itineraryForThisTour.nameOfTour;
    
    self.dataSource = [[TRVTourStopCollectionViewDataSource alloc] initWithStops:nil configuration:^(TRVTourStop * stop) {
        //self.tourStopImageView.image = stop.image;     stops do not yet have images
    }];
    self.tourStopCollectionView.dataSource = self.dataSource;
    self.collectionViewDelegate = [[TRVTourStopCollectionViewDelegateFlowLayout alloc] init];
    self.tourStopCollectionView.delegate = self.collectionViewDelegate;
    self.tourStopCollectionView.scrollsToTop = NO;

    //UIImageView *imageView = [[UIImageView alloc] initWithImage:self.tour.image];
    CGFloat width = self.theScrollViewThatHoldsAllTheOtherViews.bounds.size.width;
    TRVParallaxHeaderImageView *imageView = [[TRVParallaxHeaderImageView alloc] initWithFrame:CGRectMake(0, 0, width, width/2) andTour:self.tour];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedParrallaxImage)];
    [imageView addGestureRecognizer:tap];
    imageView.userInteractionEnabled = YES;
//    self.parallaxHeaderTourNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)]; //doesn't matter
//    [imageView addSubview:self.parallaxHeaderTourNameLabel];
//    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor magentaColor];
//    [self.parallaxHeaderTourNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(imageView.mas_bottom);
//        make.left.equalTo(@0);
//        make.height.equalTo(imageView.mas_height).dividedBy(10);
//        make.width.equalTo(imageView.mas_width);
//    }];

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
