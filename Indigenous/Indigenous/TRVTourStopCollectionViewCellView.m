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
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextBeginPath(context);
    CGRect smallerRect = CGRectInset(rect, 3, 3);
    CGContextAddEllipseInRect(context, smallerRect);
    CGContextDrawPath(context, kCGPathFillStroke);
    //CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    //CGRect smallerRect = CGRectInset(self.bounds, self.bounds.size.width/2, self.bounds.size.height/2);
    //CGContextFillEllipseInRect(context, rect);
    //CGContextStrokePath(context);

//    var context = UIGraphicsGetCurrentContext()
//    CGContextSetLineWidth(context, 2.0)
//    CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
//    if drawIt == DrawIt.o {
//        var rectangle = CGRectMake(4, 4, self.frame.width-8, self.frame.height-8)
//        CGContextAddEllipseInRect(context, rectangle)
//    }
//    else if drawIt == DrawIt.x {
//        var rectangle = CGRectMake(4, 4, self.frame.width-8, self.frame.height-8)
//        CGContextMoveToPoint(context, rectangle.origin.x, rectangle.origin.y)
//        CGContextAddLineToPoint(context, rectangle.width, rectangle.height)
//        CGContextMoveToPoint(context, rectangle.origin.x + rectangle.width, rectangle.origin.y)
//        CGContextAddLineToPoint(context, rectangle.origin.x, rectangle.origin.y + rectangle.height)
//    }
//    CGContextStrokePath(context)
}


@end
