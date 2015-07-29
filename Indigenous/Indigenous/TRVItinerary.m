//
//  TRVItinerary.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVItinerary.h"

@implementation TRVItinerary

-(id)initWithItinerary:(TRVItinerary *)anItinerary {
    if (!self) {
        return nil;
    }
    
    _stop        = anItinerary.stops;
    _legs        = anItinerary.legs;
    _attractions = anItinerary.attractions;
    
    return self;
}



@end
