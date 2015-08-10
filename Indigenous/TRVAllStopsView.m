//
//  TRVAllStopsView.m
//  
//
//  Created by Leo Kwan on 8/10/15.
//
//



#import "TRVAllStopsView.h"
#import <Masonry/Masonry.h>
#import "TRVTourStop.h"
#import "NSMutableArray+extraMethods.h"
#import "TRVUserDataStore.h"

@interface TRVAllStopsView()

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic)  UIImageView *stopImageView;
@property (nonatomic, strong) NSArray *stopsForThisTour;
@property (nonatomic, strong) TRVItinerary *itineraryForThisTour;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@end

@implementation TRVAllStopsView


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
        self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    }

    return self;
}

-(void)setTourForThisScrollNib:(TRVTour *)tourForThisScrollNib {

    // set info to nib
    _tourForThisScrollNib = tourForThisScrollNib;
    _itineraryForThisTour = tourForThisScrollNib.itineraryForThisTour;
    _stopsForThisTour = tourForThisScrollNib.itineraryForThisTour.tourStops;
    TRVTourStop *stop = self.stopsForThisTour[0];
    _stopImageView.image = stop.image;

}


-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                  owner:self
                                options:nil];
    
    [self addSubview:self.containerView];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *tours = [array returnDummyAllTripsArrayForGuide:self.sharedDataStore.loggedInUser];
    
    // OVERRIDE SETTER
    self.tourForThisScrollNib = tours[0];
    
    
    // This add subviews to show about root nib view
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView.mas_height);
        make.width.equalTo(@1000);
    }];
    

    id currentLeft = self.contentView.mas_left;
    
    for (int i = 0; i < self.stopsForThisTour.count; i++) {
        UIImageView *tourImageView = [[UIImageView alloc] init];
        TRVTourStop *stopForThisTour = self.stopsForThisTour[i];
        UIImage *stopImage = stopForThisTour.image;
        tourImageView.image = stopImage;
        
        [self.contentView addSubview:tourImageView];
        [tourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.scrollView.mas_width);
            make.height.equalTo(self.contentView.mas_height);
            make.left.equalTo(currentLeft);
            make.top.equalTo(self.scrollView.mas_left);
        }];
        currentLeft = tourImageView.mas_right;
    }
    


    for (TRVTourStop *stop in self.itineraryForThisTour.tourStops) {
        NSLog(@"%f", stop.tourStopLocation.latitude);
        NSLog(@"ARE YOU IN HERE??");
    }
    


    
}



@end
