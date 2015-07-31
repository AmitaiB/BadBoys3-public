//
//  TRVItinerary.h
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <PFObject.h>

@interface TRVItinerary : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *stops;       //...of TRVTourStops
@property (nonatomic, strong) NSArray *legs;        //Portion of a journey between two scheduled stops. Not certain if this is necessary.
@property (nonatomic, strong) NSArray *attractions; //Attractions: Item of specific interest to travelers, such as natural wonders, manmade facilities and structures, entertainment, and activities.


-(instancetype)initWithItinerary:(TRVItinerary *)anItinerary;

-(instancetype)initWithStops:(NSArray *)arrayOfStops;

@end
