//
//  TRVContactTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVContactTableViewCell.h"

@interface TRVContactTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *contactCategoryLabel;
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

    _userForThisContactCell = userForThisContactCell;
    self.contactCategoryLabel.text = @"Contact";
    
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.text = @"email";
    
    [self.contentView addSubview:emailLabel];

    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contactCategoryLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.contactCategoryLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottomMargin);
    }];
}

@end
