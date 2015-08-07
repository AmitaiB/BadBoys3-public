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
    self.imageView = [[TRVParallaxHeaderImageView alloc] initWithFrame:CGRectMake(0, 0, width, width/2) andTour:self.tour];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedParrallaxImage)];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = YES;
    self.parallaxHeaderTourNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)]; //doesn't matter
    [self.theScrollViewThatHoldsAllTheOtherViews addSubview:self.parallaxHeaderTourNameLabel];
    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor magentaColor];

    [self.theScrollViewThatHoldsAllTheOtherViews addParallaxWithView:self.imageView andHeight:self.imageView.bounds.size.height];
    //[self.parallaxHeaderTourNameLabel setFrame:CGRectMake(0, self.imageView.bounds.size.height - self.view.bounds.size.height / 10, self.view.bounds.size.width, self.view.bounds.size.height / 10)];
//    [self.parallaxHeaderTourNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        //make.bottom.equalTo(self.imageView.mas_bottom);
//        make.bottom.equalTo(@0);
//        make.left.equalTo(@0);
//        make.height.equalTo(@([UIScreen mainScreen].bounds.size.height / 10));
//        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
//    }];
    [self.theScrollViewThatHoldsAllTheOtherViews bringSubviewToFront:self.parallaxHeaderTourNameLabel];

    
    [self makeContentInsetFullScreen:self.theScrollViewThatHoldsAllTheOtherViews];
    [self setTitleLabelFrame:self.imageView.frame];
    
    //self.theScrollViewThatHoldsAllTheOtherViews.delegate = self;
    self.theScrollViewThatHoldsAllTheOtherViews.parallaxView.delegate = self;
    // Do any additional setup after loading the view.
    NSLog(@"The difference: %f", self.imageView.frame.size.height + self.navigationController.navigationBar.bounds.size.height - [UIScreen mainScreen].bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    //NSLog(@"content offset: %f", targetContentOffset->y);
    if ((*targetContentOffset).y == -224)
        [self makeContentInsetFullScreen:scrollView];
    [self.parallaxHeaderTourNameLabel setFrame:CGRectMake(0, self.imageView.bounds.size.height - self.view.bounds.size.height / 10, self.view.bounds.size.width, self.view.bounds.size.height / 10)];
//    [self.parallaxHeaderTourNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(@0).with.offset(-targetContentOffset->y);
//        make.left.equalTo(@0);
//        make.height.equalTo(@([UIScreen mainScreen].bounds.size.height / 10));
//        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
//    }];
}

- (void)makeContentInsetFullScreen:(UIScrollView *)scrollView {
    UIScreen *screen = [UIScreen mainScreen];
    UIEdgeInsets inset = scrollView.contentInset;
    inset.top = screen.bounds.size.height;
    scrollView.contentInset = inset;
    scrollView.contentOffset = CGPointMake(0, -scrollView.contentInset.top);
    //NSLog(@"content offset: %f", scrollView.contentOffset.y);
//    for (CGFloat i = 0; i < self.imageView.frame.size.height; i+= self.imageView.frame.size.height / 10) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i, self.view.frame.size.width, self.view.frame.size.height/10)];
//        label.text = [NSString stringWithFormat:@"%f", i / self.imageView.frame.size.height * 10];
//        label.textColor = [UIColor whiteColor];
//        label.backgroundColor = [UIColor grayColor];
//        label.layer.borderColor = [UIColor blackColor].CGColor;
//        label.layer.borderWidth = 3.0;
//        [self.imageView addSubview:label];
//    }
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

- (void)setTitleLabelFrame:(CGRect)frame  {
    CGFloat titleHeight = [UIScreen mainScreen].bounds.size.height / 10;
    if (self.imageView.frame.size.height > [UIScreen mainScreen].bounds.size.height) {
        [self.parallaxHeaderTourNameLabel setFrame:CGRectMake(frame.origin.x, frame.origin.y + [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.bounds.size.height - titleHeight, frame.size.width, titleHeight)];
        NSLog(@"this one");
    }
    else {
        [self.parallaxHeaderTourNameLabel setFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height - titleHeight, frame.size.width,  titleHeight)];
    }
    NSLog(@"label rect: %@", NSStringFromCGRect(self.parallaxHeaderTourNameLabel.frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    //NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
    [self setTitleLabelFrame:frame];
}

@end
