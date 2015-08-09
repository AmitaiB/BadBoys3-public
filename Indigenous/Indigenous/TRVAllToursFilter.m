//
//  TRVAllToursFilter.m
//  Indigenous
//
//  Created by Leo Kwan on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTour.h"
#import "TRVAllToursFilter.h"
#import "TRVUserDataStore.h"


@interface TRVAllToursFilter ()

@end

@implementation TRVAllToursFilter

+(void)getCategoryToursForGuide:(TRVUser * )user withCompletionBlock:(void (^) (NSArray *response)) completionBlock {

   TRVUserDataStore *sharedUserDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    NSInteger _numberOfCategoryTours = 0;
    NSInteger _numberOfOtherTours = 0;
    
    for (TRVTour *tour in user.allTrips) {
        
        NSString *categoryInSearch = sharedUserDataStore.currentCategorySearching.categoryName;
        NSString *categoryForTourIndex = tour.categoryForThisTour.categoryName;
        
        if ([categoryInSearch isEqualToString: categoryForTourIndex]) {
            _numberOfCategoryTours ++;
        }
        else{
            _numberOfOtherTours ++;
        }
    }
    
    NSArray *tourCount = @[@(_numberOfCategoryTours),@( _numberOfOtherTours)];
    completionBlock(tourCount);
}

@end
