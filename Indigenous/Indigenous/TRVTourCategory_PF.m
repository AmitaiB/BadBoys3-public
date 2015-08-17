//
//  TRVTourCategory_PF.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/16/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourCategory_PF.h"

@implementation TRVTourCategory_PF
    
+(void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return NSStringFromClass([TRVTourCategory_PF class]);
}

-(NSString *)description {
    NSArray *categoryDescriptions = @[@"See",
                                      @"Play",
                                      @"Eat", @"Drink", @"NULL"];
    if (self.tourCategoryType) {
        return categoryDescriptions[self.tourCategoryType];
    }
    return @"DEFAULT CATEGORY: The worst decision is indecision.";
}

@end
