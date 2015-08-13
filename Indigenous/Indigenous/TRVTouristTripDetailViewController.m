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
#import "TRVBookTourViewController.h"
//#import "TRVTourStop.h"

#import "Masonry/Masonry.h"

@interface TRVTouristTripDetailViewController () <APParallaxViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navBarTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *tourStopCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *tourStopImageView;
@property (nonatomic, strong) TRVTourStopCollectionViewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIScrollView *theScrollViewThatHoldsAllTheOtherViews;
@property (nonatomic, strong) TRVTourStopCollectionViewDelegateFlowLayout *collectionViewDelegate;
@property (nonatomic, strong) TRVParallaxHeaderImageView *parallaxImageView;
@property (nonatomic, strong) UILabel *parallaxHeaderTourNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBookTourButtonConstraint;
@property (weak, nonatomic) IBOutlet UIButton *bookTourButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tourStopImageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bookTourBottomConstraint;
@property (weak, nonatomic) IBOutlet UILabel *tourInfoLabel;



@property (weak, nonatomic) IBOutlet UILabel *nameOfStop;

@property (weak, nonatomic) IBOutlet UIView *contactGuideXib;


@property (nonatomic) BOOL isTourGuide;
@end

@implementation TRVTouristTripDetailViewController {
    CGFloat _originalDistanceFromBottomOfScreenToBottomOfParallaxImage;
    CGFloat _savedAlphaValue;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        _isTourGuide = NO;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitle.title = self.tour.itineraryForThisTour.nameOfTour;
    
    self.dataSource = [[TRVTourStopCollectionViewDataSource alloc] initWithStops:self.tour.itineraryForThisTour.tourStops configuration:^(TRVTourStop * stop) {
        //self.tourStopImageView.image = stop.image;     stops do not yet have images
    }];
    self.tourStopCollectionView.dataSource = self.dataSource;
    self.collectionViewDelegate = [[TRVTourStopCollectionViewDelegateFlowLayout alloc] init]; // UILayoutContainerView
    
    self.collectionViewDelegate.imageView = self.tourStopImageView; // FIXME: FIX THIS UGLY SHIT!!
    
    self.tourStopCollectionView.delegate = self.collectionViewDelegate;
    self.tourStopCollectionView.scrollsToTop = NO;

    [self setupParallaxImage:self.theScrollViewThatHoldsAllTheOtherViews];
    
    _savedAlphaValue = 1;
    //self.bookTourBottomConstraint.active = NO;
    //self.topBookTourButtonConstraint.active = NO;
    
//    [self setUpTourGuideViewController];

    if (_isTourGuide == YES){
        [self setUpTourGuideViewController];
    }
//    else {
        //[NSLayoutConstraint deactivateConstraints:self.bookTourButton.constraints];
//        self.bookTourBottomConstraint.active = NO;
//        self.topBookTourButtonConstraint.active = NO;
        //[self.contentView setNeedsLayout];
        //[self.theScrollViewThatHoldsAllTheOtherViews setNeedsLayout];
        //[self.theScrollViewThatHoldsAllTheOtherViews sizeToFit];
        //[self.tourStopImageView setNeedsLayout];
    //}
    //self.contentView.backgroundColor = [UIColor magentaColor]; NOT THE PROBLEM
    self.theScrollViewThatHoldsAllTheOtherViews.backgroundColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)isTourGuideTripViewController {
    _isTourGuide = YES;
}

-(void)setUpTourGuideViewController {
    self.bookTourButton.hidden = NO;
    self.bookTourButton.backgroundColor = [UIColor greenColor];
//    self.topBookTourButtonConstraint.active = YES;
//    self.bookTourBottomConstraint.active = YES;
    [NSLayoutConstraint activateConstraints:self.bookTourButton.constraints];
    self.tourStopImageViewBottomConstraint.active = NO;
//
//    [self.bookTourButton layoutIfNeeded];
//    [self.tourStopImageView layoutIfNeeded];
//    [self.contentView layoutIfNeeded];
//    [self.theScrollViewThatHoldsAllTheOtherViews layoutIfNeeded];
//    [self.view layoutIfNeeded];
   // self.theScrollViewThatHoldsAllTheOtherViews.contentInset = UIEdgeInsetsMake(self.theScrollViewThatHoldsAllTheOtherViews.contentInset.top, 0, 40, 0);
    
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ((*targetContentOffset).y == -224)
        [self makeContentInsetFullScreen:scrollView];
    [self.parallaxHeaderTourNameLabel setFrame:CGRectMake(0, self.parallaxImageView.bounds.size.height - self.view.bounds.size.height / 10, self.view.bounds.size.width, self.view.bounds.size.height / 10)];
}

- (void)makeContentInsetFullScreen:(UIScrollView *)scrollView {
    UIScreen *screen = [UIScreen mainScreen];
    UIEdgeInsets inset = scrollView.contentInset;
    inset.top = screen.bounds.size.height;
    scrollView.contentInset = inset;
    scrollView.contentOffset = CGPointMake(0, -scrollView.contentInset.top);
}

- (void)setupParallaxImage:(UIScrollView *)scrollView {
    CGFloat width = self.theScrollViewThatHoldsAllTheOtherViews.bounds.size.width;
    self.parallaxImageView = [[TRVParallaxHeaderImageView alloc] initWithFrame:CGRectMake(0, 0, width, width/2) andTour:self.tour];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedParrallaxImage)];
    [self.parallaxImageView addGestureRecognizer:tap];
    self.parallaxImageView.userInteractionEnabled = YES;
    
    [self.theScrollViewThatHoldsAllTheOtherViews addParallaxWithView:self.parallaxImageView andHeight:self.parallaxImageView.bounds.size.height];
    //[self setupParallaxImageTitle];
    //[self.theScrollViewThatHoldsAllTheOtherViews bringSubviewToFront:self.parallaxHeaderTourNameLabel];
    [self makeContentInsetFullScreen:self.theScrollViewThatHoldsAllTheOtherViews];
}

- (void)setupParallaxImageTitle {
    self.parallaxHeaderTourNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)]; //doesn't matter
    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor magentaColor];
    self.parallaxHeaderTourNameLabel.text = self.tour.itineraryForThisTour.nameOfTour;
    self.parallaxHeaderTourNameLabel.textColor = [UIColor whiteColor];
    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor clearColor];
    
    CGFloat titleLabelHeight = self.parallaxImageView.bounds.size.height / 10;
    [self.parallaxHeaderTourNameLabel setFrame:CGRectMake(0, self.parallaxImageView.frame.origin.y - titleLabelHeight, self.view.frame.size.width, titleLabelHeight)];
    
    self.theScrollViewThatHoldsAllTheOtherViews.parallaxView.delegate = self;
    // Do any additional setup after loading the view.
    //NSLog(@"The difference: %f", self.parallaxImageView.frame.size.height + self.navigationController.navigationBar.bounds.size.height - [UIScreen mainScreen].bounds.size.height);
    
    UIView *viewToAddTitleLabelTo = (UIView*)([[[UIApplication sharedApplication] keyWindow] subviews][0]);
    [viewToAddTitleLabelTo addSubview:self.parallaxHeaderTourNameLabel];
    UITabBar *tabBar = [viewToAddTitleLabelTo subviews][1];
    [self.parallaxHeaderTourNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tabBar.mas_top);
        make.width.equalTo(tabBar.mas_width);
        make.left.equalTo(tabBar.mas_left);
        make.height.equalTo(tabBar.mas_height);
    }];
    
    [viewToAddTitleLabelTo bringSubviewToFront:self.parallaxHeaderTourNameLabel];
    
    _originalDistanceFromBottomOfScreenToBottomOfParallaxImage =  [self.tourInfoLabel.superview convertPoint:self.tourInfoLabel.frame.origin toView:nil].y - ([self.parallaxHeaderTourNameLabel.superview convertPoint:self.parallaxHeaderTourNameLabel.frame.origin toView:nil].y);
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
//    NSLog(@"y value of title: %f", self.parallaxHeaderTourNameLabel.frame.origin.y);
//    NSLog(@"y value of other label: %f", self.tourInfoLabel.frame.origin.y);
//    
//    NSLog(@"y value of bottom of title in absolute coordinates: %f",[self.parallaxHeaderTourNameLabel.superview convertPoint:self.parallaxHeaderTourNameLabel.frame.origin toView:nil].y + self.parallaxHeaderTourNameLabel.frame.size.height);
//    NSLog(@"y value of tour info label in absolute coordinates: %f", [self.tourInfoLabel.superview convertPoint:self.tourInfoLabel.frame.origin toView:nil].y);
    
    
    [self setAlphaForParallaxTitleLabel];
}

- (void)setAlphaForParallaxTitleLabel {
    self.parallaxHeaderTourNameLabel.alpha = ([self.tourInfoLabel.superview convertPoint:self.tourInfoLabel.frame.origin toView:nil].y - ([self.parallaxHeaderTourNameLabel.superview convertPoint:self.parallaxHeaderTourNameLabel.frame.origin toView:nil].y + self.parallaxHeaderTourNameLabel.frame.size.height)) / _originalDistanceFromBottomOfScreenToBottomOfParallaxImage;
//    NSLog(@"tour name label new alpha: %f", self.parallaxHeaderTourNameLabel.alpha);
//    self.parallaxHeaderTourNameLabel.alpha = 1;
//    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor orangeColor];
}


- (IBAction)bookTourButtonTapped:(id)sender {
    
    UIStoryboard *destinationStoryboard = [UIStoryboard storyboardWithName:@"bookTour" bundle:nil];;
    
    TRVBookTourViewController *destination = [destinationStoryboard instantiateInitialViewController];
    
    // pass it into confirm purchase Storyboard
    destination.destinationTour = self.tour;
    
    // Alan can you check if this is right
    [self presentViewController:destination animated:NO completion:nil];

    //NSLog(@"%@", @"PBBBBBBBBBBBT");
    
}




- (void)viewWillAppear:(BOOL)animated {
//    self.parallaxHeaderTourNameLabel.hidden = NO;
//    UIView *viewToAddTitleLabelTo = ((UIView*)[((UIView*)([[[UIApplication sharedApplication] keyWindow] subviews][0])) subviews][0]);
//    [viewToAddTitleLabelTo bringSubviewToFront:self.parallaxHeaderTourNameLabel];
//    self.parallaxHeaderTourNameLabel.alpha = _savedAlphaValue;
}

-(UIView*)viewWithTabBarAsSubview {
    return nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.parallaxHeaderTourNameLabel.hidden = YES;
    _savedAlphaValue = self.parallaxHeaderTourNameLabel.alpha;
}

@end
