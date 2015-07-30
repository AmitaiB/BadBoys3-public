//
//  TRVUserSnippetTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserSnippetTableViewCell.h"

@interface TRVUserSnippetTableViewCell()

@property (nonatomic, strong) TRVBio *bioForThisUser;

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
    self.nameLabel.text = user.userBio.firstName;
    self.homeCityLabel.text = user.userBio.homeCity;
    self.homeCountryLabel.text = user.userBio.homeCountry;
}


@end
