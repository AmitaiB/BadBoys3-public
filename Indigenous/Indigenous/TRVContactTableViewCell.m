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
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

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
    self.emailLabel.text = userForThisContactCell.userBio.email;
}

@end
