//
//  TRVGuideTableView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/7/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVGuideTableView.h"

@implementation TRVGuideTableView


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
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Hey, were changes made"?
    
    //if changes made, then call on updateConstraints:
    
    //else dont do anything
    
    [self setNeedsUpdateConstraints];

    
    
    
}

- (void)updateConstraints {
    
    // THIS MAKES SURE WHATEVER VIEW THE NIB INHABITS, OUR SUBVIEWS HIT THE EDGES
    UIView *view = self.contentView;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|[view]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|[view]|" options:0 metrics:nil views:views]];
    [self addConstraints:constraints];
    [super updateConstraints];
}


@end
