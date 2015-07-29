//
//  TRVEvent.m
//  Indigenous
//
//  Created by Leo Kwan on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStop.h"

@implementation TRVTourStop


-(instancetype)initWithLocation:(NSString *)location address:(NSString *)address cost:(CGFloat)cost description:(NSString *)description {

    self = [super init];
    
    if (self) {
        _locationOfEvent = location;
        _addressOfEvent = address;
        _costOfEvent = cost;
        _descriptionOfEvent = description;
    }
    
    return self;
};





@end
