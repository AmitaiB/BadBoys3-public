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
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height/2 - .5);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height/2 - .5);
    
    CGRect smallerRect = CGRectInset(rect, 5, 1);
    CGContextAddEllipseInRect(context, smallerRect);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);

//    CGRect evenSmallerRect = CGRectInset(smallerRect, 10, 10);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillEllipseInRect(context, evenSmallerRect);
    
    }


@end
