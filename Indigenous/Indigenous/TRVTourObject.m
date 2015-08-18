//
//  TRVTourDataPF.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourObject.h"

@implementation TRVTourObject

-(instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _tourName       = @"";
    _tourCategory   = @"";
    _tourCategories = @[@"See", @"Play", @"Eat", @"Drink"];
    _tourDate       = [NSDate distantFuture];
    _tourImage      = [UIImage imageWithData:[NSData data]];
    _tourItinerary  = [NSMutableArray new];
    
    return self;
}



@end
