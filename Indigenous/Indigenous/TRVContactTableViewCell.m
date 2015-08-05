//
//  TRVContactTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVContactTableViewCell.h"
#import "TRVUserContactView.h"
#import <Masonry/Masonry.h>

@interface TRVContactTableViewCell()

@property (weak, nonatomic) IBOutlet TRVUserContactView *cellContactContentView;


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
    self.cellContactContentView.userForThisContactView = userForThisContactCell;
//    
//    [self.cellContactContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
//    }];
//    

    
    
}

@end
