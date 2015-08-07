//
//  TRVGuideProfileImageView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVGuideProfileImageView.h"
#import <Masonry/Masonry.h>
#import <QuartzCore/QuartzCore.h>


@interface TRVGuideProfileImageView ()

@property (strong, nonatomic) IBOutlet UIView *guideProfileView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *guideTagLineLabel;


@end

@implementation TRVGuideProfileImageView


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
    
    [self addSubview:self.guideProfileView];
    [self createCircleImageViewMask];

    
    // set constraints for imageView to superview
    [self.guideProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

-(void)createCircleImageViewMask {
    CALayer *imageLayer = self.profileImageView.layer;

    //convert uicolor to CGColor
    imageLayer.borderColor = [[UIColor grayColor] CGColor];
    [imageLayer setCornerRadius:self.profileImageView.frame.size.width/2];
    [imageLayer setBorderWidth:2];
    [imageLayer setMasksToBounds:YES];

}

@end
