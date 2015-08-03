//
//  TRVGuideProfileTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVGuideProfileTableViewCell.h"
#import "TRVGuideProfileImageView.h"
#import "TRVGuideDetailProfileView.h"
#import <Masonry.h>

@interface TRVGuideProfileTableViewCell ()

@property (nonatomic, strong) NSArray *profileScrollViewItems;
@property (nonatomic, strong) TRVGuideProfileImageView *profileImageNib;
@property (nonatomic, strong) TRVGuideDetailProfileView *detailedProfileNib;

@end

@implementation TRVGuideProfileTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void) setGuideForThisCell:(TRVUser *)guideForThisCell {
    _guideForThisCell = guideForThisCell;
    [self layoutConstraintsForProfileSection];
}



-(void) layoutConstraintsForProfileSection {
    

    // Set Profile Image View Constraints
    
    [self.contentView addSubview:self.profileSectionContentView];
    
    // Set constraints for ROOT PROFILE Content View
    [self.profileSectionContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.rightMargin.equalTo(self.contentView.mas_rightMargin);
        
        // SET the height of Profile scroll view to 2/3 of entire cell height
        make.height.equalTo(self.contentView.mas_height).dividedBy(1.5);
    }];
    
    
    // LAYOUT NIBS
    [self layoutNibConstraints];
    
    // LAYOUT PROFILE SCROLL VIEW
    [self layoutProfileScrollView];
    
}




-(void) layoutProfileScrollView {
    
    // SET constraints for SCROLL VIEW
    [self.guideProfileScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        // Lock Scroll View Height
        self.guideProfileScrollView.backgroundColor = [UIColor greenColor];
    }];
    
    
    
    
    //SET constraints for scroll CONTENT view
    
    [self.guideProfileScrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // Lock Scroll Content Height
        make.height.equalTo(self.guideProfileScrollView.mas_height);
        
        // SET right margin of Scroll Content View To last item in items array
        
        make.right.equalTo(self.detailedProfileNib.mas_right);
        self.guideProfileScrollContentView.backgroundColor = [UIColor blueColor];
    }];
}


-(void) layoutNibConstraints {
    
    
    // ADD Profile Image View Nib
    
    self.profileImageNib = [[TRVGuideProfileImageView alloc] init];
    [self.guideProfileScrollContentView addSubview:self.profileImageNib];
    
    // SET Profile View Nib Constraints
    
    
    [self.profileImageNib mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.guideProfileScrollView.mas_left);
        make.top.equalTo(self.guideProfileScrollView.mas_top);
        make.bottom.equalTo(self.guideProfileScrollView.mas_bottom);
        
        make.height.equalTo(self.guideProfileScrollView.mas_height);
        make.width.equalTo(self.guideProfileScrollView.mas_width);
    }];
    
    
    //SET DETAILED Profile View Nib Constraints
    
    self.detailedProfileNib = [[TRVGuideDetailProfileView alloc] init];
    
    [self.guideProfileScrollContentView addSubview:self.detailedProfileNib];
    
    // SET constraints for Profile View Nib
    
    [self.detailedProfileNib mas_makeConstraints:^(MASConstraintMaker *make) {
        // set all edges to superview edges except right margin
        make.left.equalTo(self.profileImageNib.mas_right);
        make.top.equalTo(self.guideProfileScrollContentView.mas_top);
        make.bottom.equalTo(self.guideProfileScrollContentView.mas_bottom);
        
        
        make.height.equalTo(self.guideProfileScrollView.mas_height);
        make.width.equalTo(self.guideProfileScrollView.mas_width);
    }];
    
}


@end
