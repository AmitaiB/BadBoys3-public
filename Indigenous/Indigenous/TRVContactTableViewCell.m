//
//  TRVContactTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVContactTableViewCell.h"

@interface TRVContactTableViewCell()

//@property (weak, nonatomic) IBOutlet UILabel *contactCategoryLabel;
//@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation TRVContactTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUserForThisContactCell:(TRVUser *)userForThisContactCell {
    
    // set logged in TRV User
    _userForThisContactCell = userForThisContactCell;

    
    // Set height of content view
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@100);
    }];
    
    // EMAIL LABELS ARE PROGRAMATICALLY SET
    UILabel *contactLabel = [[UILabel alloc] init];
    contactLabel.text = @"Yo";
    
    [self.contentView addSubview:contactLabel];
    
    
    [contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(20);
        make.left.equalTo(self.contentView.mas_left);
    }];
    
    // add email label
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.text = @"email";
    [self.contentView addSubview:emailLabel];

    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contactLabel.mas_bottom).with.offset(5);
        make.left.equalTo(contactLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottomMargin).with.offset(20);
    }];
    
    // add USER email label
    UILabel *userEmailLabel = [[UILabel alloc] init];
    userEmailLabel.text = self.userForThisContactCell.userBio.email;
    [self.contentView addSubview:userEmailLabel];
    
    [userEmailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emailLabel.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottomMargin);
    }];

    
    
}

@end
