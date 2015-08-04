//
//  ProfileImageTableViewCell.m
//  Pods
//
//  Created by Leo Kwan on 7/30/15.
//
//

#import "TRVProfileImageTableViewCell.h"
#import <Parse.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

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
    
       
    // ADDED IMAGE VIEW PROGRAMATICALLY
    
    // Created the profile image view
    UIImageView *profilePictureImageView = [[UIImageView alloc] init];
    profilePictureImageView.image = userForThisImageCell.userBio.profileImage;
    
    // added imageview to superview
    [self.contentView addSubview:profilePictureImageView];
    
    profilePictureImageView.backgroundColor = [UIColor purpleColor];
    
    // set imageview constraints
    [profilePictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        
        // what should the image height be?
        make.height.equalTo(@300);
           }];
    
}

@end
