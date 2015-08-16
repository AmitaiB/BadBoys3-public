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

@end
