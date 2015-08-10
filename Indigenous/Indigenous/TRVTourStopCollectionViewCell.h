//
//  TRVCollectionViewCell.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRVTourStop;

@interface TRVTourStopCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) TRVTourStop *stop;

-(void)selectionAnimation;
-(void)fixIt :(CGSize)size;

@end
