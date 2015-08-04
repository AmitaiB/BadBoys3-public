//
//  TRVUserSnippetTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserSnippetTableViewCell.h"
#import <Masonry.h>
#import "TRVUserSnippetView.h"

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
    
    // ADD User Snippet Nib
    TRVUserSnippetView *userSnippetView = [[TRVUserSnippetView alloc] init];
    userSnippetView.userForThisSnippetView = user;
    self.cellContentUIView = userSnippetView.userSnippetContentView;
    userSnippetView.firstNameLabel.text = user.userBio.firstName;
    NSLog(@"%@!!~~~!!",userSnippetView.firstNameLabel.text );
}


@end
