//
//  TRVUserSnippetView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUserSnippetView.h"

@interface TRVUserSnippetView ()

@end

@implementation TRVUserSnippetView


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
    
    [self addSubview:self.userSnippetContentView];
    
}


@end
