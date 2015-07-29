//
//  TRVItinerary.h
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "PFObject.h"


@interface TRVItinerary : PFObject

@property (nonatomic, strong) NSArray *stops;       //Self-explanatory
@property (nonatomic, strong) NSArray *legs;        //Portion of a journey between two scheduled stops.


@end
