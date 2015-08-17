//
//  TRVTour_PF.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/16/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTour_PF.h"

@implementation TRVTour_PF
+(void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return NSStringFromClass([TRVTour_PF class]);
}

-(instancetype)initWithDefaultValues {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.tourGuide = [PFUser currentUser].username;
    self.tourName = @"Your Awesome Tour!";
    self.tourCategory = @"The Paradox of Choice!";
    self.depatureDate = nil;
    self.tourStopGeoPoints = nil;
    
    return self;
}

-(instancetype)init {
    return [self initWithDefaultValues];
}

-(NSArray *)allValues {
    NSMutableArray *temp = [NSMutableArray new];
    temp[0] = self.tourGuide;
    temp[1] = self.tourName;
    temp[2] = [self.tourCategory description];
    temp[3] = [self.depatureDate description];
    temp[4] = [NSString stringWithFormat:@"Itinerary with %@ locations",[@(self.tourStopGeoPoints.count) stringValue]];
    
    return [temp copy];
}


@end
