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

@interface TRVTouristTripDetailViewController () <APParallaxViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navBarTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *tourStopCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *tourStopImageView;
@property (nonatomic, strong) TRVTourStopCollectionViewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIScrollView *theScrollViewThatHoldsAllTheOtherViews;
@property (nonatomic, strong) TRVTourStopCollectionViewDelegateFlowLayout *collectionViewDelegate;
@property (nonatomic, strong) TRVParallaxHeaderImageView *imageView;
@property (nonatomic, strong) UILabel *parallaxHeaderTourNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tourInfoLabel;
@end

@implementation TRVTouristTripDetailViewController {
    CGFloat _originalDistanceFromBottomOfScreenToBottomOfParallaxImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitle.title = self.tour.itineraryForThisTour.nameOfTour;
    
    self.dataSource = [[TRVTourStopCollectionViewDataSource alloc] initWithStops:self.tour.itineraryForThisTour.tourStops configuration:^(TRVTourStop * stop) {
        //self.tourStopImageView.image = stop.image;     stops do not yet have images
    }];
    self.tourStopCollectionView.dataSource = self.dataSource;
    self.collectionViewDelegate = [[TRVTourStopCollectionViewDelegateFlowLayout alloc] init]; // UILayoutContainerView
    
    self.collectionViewDelegate.imageView = self.tourStopImageView; // FIX THIS UGLY SHIT!!!
    
    self.tourStopCollectionView.delegate = self.collectionViewDelegate;
    self.tourStopCollectionView.scrollsToTop = NO;

    CGFloat width = self.theScrollViewThatHoldsAllTheOtherViews.bounds.size.width;
    self.imageView = [[TRVParallaxHeaderImageView alloc] initWithFrame:CGRectMake(0, 0, width, width/2) andTour:self.tour];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedParrallaxImage)];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = YES;
    self.parallaxHeaderTourNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)]; //doesn't matter
    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor magentaColor];
    self.parallaxHeaderTourNameLabel.text = self.tour.itineraryForThisTour.nameOfTour;
    self.parallaxHeaderTourNameLabel.textColor = [UIColor whiteColor];
    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor clearColor];

    [self.theScrollViewThatHoldsAllTheOtherViews addParallaxWithView:self.imageView andHeight:self.imageView.bounds.size.height];

    [self.theScrollViewThatHoldsAllTheOtherViews bringSubviewToFront:self.parallaxHeaderTourNameLabel];

    
    [self makeContentInsetFullScreen:self.theScrollViewThatHoldsAllTheOtherViews];
    CGFloat titleLabelHeight = self.imageView.bounds.size.height / 10;
    [self.parallaxHeaderTourNameLabel setFrame:CGRectMake(0, self.imageView.frame.origin.y - titleLabelHeight, self.view.frame.size.width, titleLabelHeight)];
    
    
    self.theScrollViewThatHoldsAllTheOtherViews.parallaxView.delegate = self;
    // Do any additional setup after loading the view.
    NSLog(@"The difference: %f", self.imageView.frame.size.height + self.navigationController.navigationBar.bounds.size.height - [UIScreen mainScreen].bounds.size.height);
    
    UIView *viewToAddTitleLabelTo = ((UIView*)[((UIView*)([[[UIApplication sharedApplication] keyWindow] subviews][0])) subviews][0]);
    [viewToAddTitleLabelTo addSubview:self.parallaxHeaderTourNameLabel];
    UITabBar *tabBar = [viewToAddTitleLabelTo subviews][1];
    [self.parallaxHeaderTourNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tabBar.mas_top);
        make.width.equalTo(tabBar.mas_width);
        make.left.equalTo(tabBar.mas_left);
        make.height.equalTo(tabBar.mas_height);
    }];
    _originalDistanceFromBottomOfScreenToBottomOfParallaxImage =  [self.tourInfoLabel.superview convertPoint:self.tourInfoLabel.frame.origin toView:nil].y - ([self.parallaxHeaderTourNameLabel.superview convertPoint:self.parallaxHeaderTourNameLabel.frame.origin toView:nil].y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ((*targetContentOffset).y == -224)
        [self makeContentInsetFullScreen:scrollView];
    [self.parallaxHeaderTourNameLabel setFrame:CGRectMake(0, self.imageView.bounds.size.height - self.view.bounds.size.height / 10, self.view.bounds.size.width, self.view.bounds.size.height / 10)];
}

- (void)makeContentInsetFullScreen:(UIScrollView *)scrollView {
    UIScreen *screen = [UIScreen mainScreen];
    UIEdgeInsets inset = scrollView.contentInset;
    inset.top = screen.bounds.size.height;
    scrollView.contentInset = inset;
    scrollView.contentOffset = CGPointMake(0, -scrollView.contentInset.top);
}

- (void)tappedParrallaxImage {
    [UIView animateWithDuration:.25 animations:^{
        CGFloat width = self.theScrollViewThatHoldsAllTheOtherViews.bounds.size.width;
        self.theScrollViewThatHoldsAllTheOtherViews.contentOffset = CGPointMake(0, -width/2);
    } completion:^(BOOL finished) {
        CGPoint offset = self.theScrollViewThatHoldsAllTheOtherViews.contentOffset;
        [self.theScrollViewThatHoldsAllTheOtherViews setContentOffset:offset animated:NO];
    }];
}
- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    //NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
    //[self setTitleLabelFrame:frame];
    NSLog(@"y value of title: %f", self.parallaxHeaderTourNameLabel.frame.origin.y);
    NSLog(@"y value of other label: %f", self.tourInfoLabel.frame.origin.y);
    
    NSLog(@"y value of bottom of title in absolute coordinates: %f",[self.parallaxHeaderTourNameLabel.superview convertPoint:self.parallaxHeaderTourNameLabel.frame.origin toView:nil].y + self.parallaxHeaderTourNameLabel.frame.size.height);
    NSLog(@"y value of tour info label in absolute coordinates: %f", [self.tourInfoLabel.superview convertPoint:self.tourInfoLabel.frame.origin toView:nil].y);
    
    
    [self setAlphaForParallaxTitleLabel];
}

- (void)setAlphaForParallaxTitleLabel {
    self.parallaxHeaderTourNameLabel.alpha = ([self.tourInfoLabel.superview convertPoint:self.tourInfoLabel.frame.origin toView:nil].y - ([self.parallaxHeaderTourNameLabel.superview convertPoint:self.parallaxHeaderTourNameLabel.frame.origin toView:nil].y + self.parallaxHeaderTourNameLabel.frame.size.height)) / _originalDistanceFromBottomOfScreenToBottomOfParallaxImage;
    NSLog(@"tour name label new alpha: %f", self.parallaxHeaderTourNameLabel.alpha);
    self.parallaxHeaderTourNameLabel.alpha = 1;
    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor orangeColor];
}

- (void)viewWillAppear:(BOOL)animated {
    self.parallaxHeaderTourNameLabel.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.parallaxHeaderTourNameLabel.hidden = YES;
}

@end
