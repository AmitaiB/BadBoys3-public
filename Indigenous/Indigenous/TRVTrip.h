//
//  TRVTrip.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRVTrip : NSObject

//@property (nonatomic, weak, nonnull) TRVGuide *guide;
@property (nonatomic, strong, nonnull) NSMutableArray *theGuided;
@property (nonatomic, strong, nonnull) UIImage *image;
@property (nonatomic, strong, nonnull) NSDate *startTime;
@property (nonatomic) NSTimeInterval duration;
//@property (nonatomic, strong, nonnull) TRVRoute *route;

@end
