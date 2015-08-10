//
//  TRVAllStopsView.m
//  
//
//  Created by Leo Kwan on 8/10/15.
//
//



#import "TRVAllStopsView.h"
#import <Masonry/Masonry.h>

@interface TRVAllStopsView()

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *stopImageView;

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
    }
    
    return self;
}

-(void)setTourForThisScrollNib:(TRVTour *)tourForThisScrollNib {

}


-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                  owner:self
                                options:nil];
    
    [self addSubview:self.containerView];
    
    // This add subviews to show about root nib view

    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
//    [self.containerView addSubview:self.contentView];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView.mas_height);
        make.width.equalTo(@1000);
    }];
    
    [self.stopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.equalTo(self.contentView);
        make.height.equalTo(self.scrollView.mas_height);
        make.width.equalTo(self.scrollView.mas_width);
    }];
    
    
    
}



@end
