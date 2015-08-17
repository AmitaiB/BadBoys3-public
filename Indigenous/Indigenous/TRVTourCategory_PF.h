//
//  TRVTourCategory_PF.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/16/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Parse.h>

@interface TRVTourCategory_PF : PFObject <PFSubclassing>
+ (NSString *)parseClassName;

typedef NS_ENUM(NSInteger, TRVTourCategoryType){
    TRVTourCategorySee,
    TRVTourCategoryPlay,
    TRVTourCategoryEat,
    TRVTourCategoryDrink,
    TRVTourCategoryNull
};

@property (nonatomic) TRVTourCategoryType tourCategoryType;

-(NSString*)description;

@end
