//
//  TRVSocialMediaTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVSocialMediaTableViewCell.h"

@interface TRVSocialMediaTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation TRVSocialMediaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUserForThisConnectCell:(TRVUser *)userForThisConnectCell {
    _userForThisConnectCell = userForThisConnectCell;
    
    UIButton *socialMediaButton = [[UIButton alloc] init];
    [self.contentView addSubview:socialMediaButton];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        //        make.height.equalTo(@100);
        //        make.width.equalTo(@400);
        self.contentView.backgroundColor = [UIColor grayColor];
    }];
    
    [socialMediaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        socialMediaButton.backgroundColor = [UIColor greenColor];
        make.height.equalTo(@50);
        make.width.equalTo(@50);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    

}

@end
