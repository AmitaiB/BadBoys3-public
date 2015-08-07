//
//  TRVProfileAboutMeView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserAboutMeView.h"
#import <Masonry.h>

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
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    //Hey, were changes made"?
    
    //if changes made, then call on updateConstraints:
    
    //else dont do anything
    
    
    // DO I NEED BELOW??
    [self setNeedsUpdateConstraints];


    
}
//
//- (void)updateConstraints {
//    
//
//    UIView *view = self.contentView;
//
//    
//    NSDictionary *views = NSDictionaryOfVariableBindings(view);
//    NSMutableArray *constraints = [[NSMutableArray alloc] init];
//    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[view]|" options:0 metrics:nil views:views]];
//    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|[view]|" options:0 metrics:nil views:views]];
//    [self addConstraints:constraints];
//    [super updateConstraints];
//}

-(void)setUserForThisAboutMeView:(TRVUser *)userForThisAboutMeView {
    
    _userForThisAboutMeView = userForThisAboutMeView;
    self.userAboutMeLabel.text = userForThisAboutMeView.userBio.bioDescription;
}


@end
