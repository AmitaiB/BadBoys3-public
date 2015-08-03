//
//  TRVTourCategoryView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVTourCategoryView.h"


@interface TRVTourCategoryView ()


@end

@implementation TRVTourCategoryView

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
    
    [self addSubview:self.categoryContentView];
    [self.categoryContentView addSubview:self.categoryImageView];
    [self.categoryContentView addSubview:self.iconImageView];
    [self.categoryContentView addSubview:self.categoryNameLabel];

    // set constraints for imageView to superview
}

//
-(void)setCategoryForThisView:(TRVTourCategory *)categoryForThisView {
    
    NSLog(@"In setter method, are you getting called?");

    _categoryForThisView = categoryForThisView;
    
    self.categoryImageView.image = categoryForThisView.categoryImage;
    self.iconImageView.image = categoryForThisView.iconImage;
    self.categoryNameLabel.text = categoryForThisView.categoryName;

    
}

@end
