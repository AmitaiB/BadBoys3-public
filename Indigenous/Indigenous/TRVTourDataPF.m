//
//  TRVTourDataPF.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourDataPF.h"

@implementation TRVTourDataPF
@synthesize tourName;
@synthesize tourCategories;
@synthesize tourCategory;
@synthesize tourDate;
@synthesize tourImage;
@synthesize tourItinerary;


+(void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return NSStringFromClass([TRVTourDataPF class]);
}

-(instancetype)init {
    self = [super initWithClassName:[TRVTourDataPF parseClassName]];
    if (!self) {
        return nil;
    }
    
    tourName       = @"";
    tourCategory   = @"";
    tourCategories = @[@"See", @"Play", @"Eat", @"Drink"];
    tourDate       = [NSDate distantFuture];
    tourImage      = [PFFile fileWithData:[NSData data]];
    tourItinerary  = [NSMutableArray new];
    
    return self;
}



@end
