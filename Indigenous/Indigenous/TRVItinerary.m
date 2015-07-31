//
//  TRVItinerary.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVItinerary.h"

@implementation TRVItinerary

-(instancetype)initWithItinerary:(TRVItinerary *)anItinerary {

    self = [super init];
    if (self) {
        
        _name        = anItinerary.name;
        _stops       = anItinerary.stops;
        _legs        = anItinerary.legs;
        _attractions = anItinerary.attractions;
    }
    
    return self;
}


-(instancetype)initWithName:(NSString*)name Stops:(NSArray *)arrayOfStops {
    _stops       = arrayOfStops;
    _legs        = [NSArray new];
    _attractions = [NSArray new];
    return self;
}


@end
