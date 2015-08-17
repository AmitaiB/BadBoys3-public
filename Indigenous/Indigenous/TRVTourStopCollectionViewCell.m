//
//  TRVCollectionViewCell.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStopCollectionViewCell.h"
#import "TRVTourStopCollectionViewCellView.h"

@implementation TRVTourStopCollectionViewCell {
    UIView *_myContentView;
}

-(void)selectionAnimation {
    self.backgroundColor = [UIColor redColor];
    NSLog(@"selected cell's view's frame: %@", NSStringFromCGRect(_myContentView.frame));
}

-(void)deselectionAnimation {
    self.backgroundColor = [UIColor blueColor];
}
-(void)awakeFromNib {
    [super awakeFromNib];
//    self.contentView.backgroundColor = [UIColor greenColor];
//    NSLog(@"Origin before:%f", self.contentView.frame.origin.x);
//    self.contentView.center = CGPointMake(self.contentView.center.x + 10, self.contentView.center.y + 10);
//    self.contentView.bounds = CGRectInset(self.bounds, 10, 10);
//    self.backgroundView.backgroundColor = [UIColor redColor];
    [self.contentView removeFromSuperview];
    _myContentView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 5, 0)];
    [self addSubview:_myContentView];
    [self setNeedsLayout];
    [self bringSubviewToFront:_myContentView];
    NSLog(@"x coordinate: %f", self.frame.origin.x);
    NSLog(@"width: %f", self.frame.size.width);
//    NSLog(@"subview x coordinate: %f", view.frame.origin.x);
//    NSLog(@"subview y coordinate: %f", view.frame.origin.y);
//    NSLog(@"subview width: %f", view.frame.size.width);
//    NSLog(@"subview height: %f", view.frame.size.height);
//    NSLog(@"my width: %f", self.frame.size.width);
//    NSLog(@"my height: %f", self.frame.size.height);
    _myContentView.backgroundColor = [UIColor greenColor];
    //self.contentView = [[TRVTourStopCollectionViewCellView alloc] initWithFrame:self.frame];
    //    [self setNeedsDisplay];
    //NSLog(@"Center after:%f", self.contentView.frame.origin.x);
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (_myContentView)
        [_myContentView removeFromSuperview];
    _myContentView = [[TRVTourStopCollectionViewCellView alloc] initWithFrame:CGRectOffset(CGRectInset(self.bounds, self.bounds.size.width/10, self.bounds.size.height/10), 0, 0)];
    [self addSubview:_myContentView];
    [self setNeedsLayout];
}

-(void)fixIt :(CGSize)size {
    [self setNeedsLayout];
    if (_myContentView)
        [_myContentView removeFromSuperview];
    _myContentView = [[TRVTourStopCollectionViewCellView alloc] initWithFrame:CGRectOffset(CGRectInset(self.bounds, size.width/10, size.height/10), 0, 0)];
    [self addSubview:_myContentView];
    [self setNeedsLayout];
}

-(void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self setNeedsLayout];
    if (_myContentView)
        [_myContentView removeFromSuperview];
    _myContentView = [[TRVTourStopCollectionViewCellView alloc] initWithFrame:CGRectOffset(CGRectInset(bounds, bounds.size.width/10, bounds.size.height/10), 0, 0)];
    [self addSubview:_myContentView];
    [self setNeedsLayout];
    NSLog(@"Cell's bounds: %@", NSStringFromCGRect(bounds));
    NSLog(@"View's frame: %@", NSStringFromCGRect(_myContentView.frame));
}

//-(void)prepareForReuse {
//    
//}

@end