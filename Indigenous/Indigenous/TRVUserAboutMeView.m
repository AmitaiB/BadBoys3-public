//
//  TRVProfileAboutMeView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserAboutMeView.h"
#import <Masonry.h>

@interface TRVUserAboutMeView()

@end

@implementation TRVUserAboutMeView



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
    
    [self addSubview:self.contentView];
    
    [self checkIfuserForThisViewIsGuide];
    NSLog(@"are you checking if user is guide?");
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

-(void)checkIfuserForThisViewIsGuide {
    if (self.userForThisAboutMeView.userBio.isGuide) {
        self.switchToGuideButton.hidden = YES;
    }
    self.switchToGuideButton.hidden = NO;
}

-(void)setUserForThisAboutMeView:(TRVUser *)userForThisAboutMeView {
    
    _userForThisAboutMeView = userForThisAboutMeView;
    self.userAboutMeLabel.text = userForThisAboutMeView.userBio.bioDescription;
}

@end
