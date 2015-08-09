//
//  TRVTourView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourView.h"
#import <Masonry/Masonry.h>

@implementation TRVTourView



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
    }
    
    return self;
}

-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                  owner:self
                                options:nil];
    
    [self addSubview:self.contentView];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

    
}

-(void)setTourForThisTourView:(TRVTour *)tourForThisTourView {
    
    _tourForThisTourView = tourForThisTourView;
    
    TRVItinerary *itineraryForThisView = tourForThisTourView.itineraryForThisTour;
    
    self.tourImageView.image = itineraryForThisView.tourImage;
    self.nameOfTourLabel.text = itineraryForThisView.nameOfTour;
    self.numberOfStopsLabel.text = [NSString stringWithFormat:@"%lu stops", itineraryForThisView.tourStops.count];;
    self.tourRatingLabel.text = [NSString stringWithFormat:@"Average Rating - %f", tourForThisTourView.tourAverageRating];
    }


;@end
