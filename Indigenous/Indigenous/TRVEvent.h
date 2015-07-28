//
//  TRVEvent.h
//  Indigenous
//
//  Created by Leo Kwan on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TRVEvent : NSObject

@property (nonatomic, strong) NSString *locationOfEvent;
@property (nonatomic, strong) NSString *addressOfEvent;
@property (nonatomic) CGFloat costOfEvent;
@property (nonatomic, strong) NSString *descriptionOfEvent;
@property (nonatomic, strong) UIImage *image;


-(instancetype)initWithLocation:(NSString *)location address:(NSString *)address cost:(CGFloat)cost description:(NSString *)description;

@end
