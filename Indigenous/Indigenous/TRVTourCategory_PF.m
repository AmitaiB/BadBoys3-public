//
//  TRVTourCategory_PF.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/16/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourCategory_PF.h"

@implementation TRVTourCategory_PF {
    NSArray *categoryDescriptions_ = @[@"See", @"Play", @"Eat", @"Drink"];
}
+(void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return NSStringFromClass([TRVTourCategory_PF class]);
}

-(NSString *)description {
    if (self.tourCategory) {
        return categoryDescriptions_[self.tourCategory];
    }
    return @"DEFAULT CATEGORY: The worst decision is indecision.";
}

@end
