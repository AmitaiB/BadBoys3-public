//
//  TRVUserContactView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserContactView.h"
#import <Masonry.h>

@implementation TRVUserContactView



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                  owner:self
                                options:nil];
    
    [self addSubview:self.userContactContentView];
//    self.userContactContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.userContactContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

-(void)setUserForThisContactView:(TRVUser *)userForThisContactView {
    
    _userForThisContactView = userForThisContactView;
    self.userEmailLabel.text = userForThisContactView.userBio.email;
    self.userLanguagesLabel.text = userForThisContactView.userBio.language;
}


@end
