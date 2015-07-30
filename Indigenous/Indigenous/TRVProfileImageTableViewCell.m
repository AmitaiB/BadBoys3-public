//
//  ProfileImageTableViewCell.m
//  Pods
//
//  Created by Leo Kwan on 7/30/15.
//
//

#import "TRVProfileImageTableViewCell.h"

@implementation TRVProfileImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUserForThisImageCell:(TRVUser *)userForThisImageCell {
    _userForThisImageCell = userForThisImageCell;
    self.profilePictureImageView.image = userForThisImageCell.userBio.profileImage;
    
    [self.profilePictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.equalTo(@300);
    }];
}

@end
