//
//  TRVTourStopCollectionViewCellView.m
//  Indigenous
//
//  Created by Daniel Wickes on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStopCollectionViewCellView.h"

@implementation TRVTourStopCollectionViewCellView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.backgroundColor = [UIColor greenColor];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor greenColor];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    self.backgroundColor = [UIColor greenColor];
//    [super drawRect:rect];
//}


@end
