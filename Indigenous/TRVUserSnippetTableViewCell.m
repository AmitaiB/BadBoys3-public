//
//  TRVUserSnippetTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserSnippetTableViewCell.h"
#import <Masonry.h>

@interface TRVUserSnippetTableViewCell()


@end

@implementation TRVUserSnippetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setUser:(TRVUser *)user {
    _user = user;
    self.firstNameLabel.text = user.userBio.firstName;
    self.lastNameLabel.text = user.userBio.lastName;
    self.homeCityLabel.text = user.userBio.homeCity;
    self.homeCountryLabel.text = user.userBio.homeCountry;
    self.userTaglineLabel.text = user.userBio.userTagline;
    
    
    // set the top padding of cell to top label
    [self.firstNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(8);

    }];
    
    // set the bottom padding of cell to bottom label
    [self.userTaglineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-8);
    }];
    
}


@end
