//
//  TRVTouristTripDataSource.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRVTouristTripDataSource : NSObject

-(instancetype)initWithTrips:(NSArray*)trips configuration:(void (^)())configureCell;

@end
