//
//  TRVGuideProfileTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVGuideProfileTableViewCell.h"
#import "TRVGuideProfileImageView.h"
#import <Masonry.h>

@interface TRVGuideProfileTableViewCell ()

@property (nonatomic, strong) TRVGuideProfileImageView *ProfileViewNib;

@end

@implementation TRVGuideProfileTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setGuideForThisCell:(TRVUser *)guideForThisCell {
    _guideForThisCell = guideForThisCell;
    NSLog(@"are you in here????");
    [self setConstraintsForProfileScroll];
}

-(void) setConstraintsForProfileScroll {
    
    
    
    self.guideProfileScrollView.backgroundColor = [UIColor orangeColor];
    
    // set constraints for scroll  view
    [self.guideProfileScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
        self.guideProfileScrollView.backgroundColor = [UIColor greenColor];
    }];
    
    
    // set constraints for scroll CONTENT view
    [self.guideProfileScrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.equalTo(self.guideProfileScrollView.mas_height);
        make.width.equalTo(@1000);
        self.guideProfileScrollContentView.backgroundColor = [UIColor redColor];
    }];
    
    
    
    // add nib
    self.ProfileViewNib = [[TRVGuideProfileImageView alloc] init];
    [self.guideProfileScrollContentView addSubview:self.ProfileViewNib];
    
    [self.ProfileViewNib mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.guideProfileScrollContentView).with.offset;
        make.height.equalTo(self.guideProfileScrollContentView);
        make.width.equalTo(@100);
    }];


}

@end
