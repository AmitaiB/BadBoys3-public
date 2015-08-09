//
//  TRVCategory.m
//  Indigenous
//
//  Created by Leo Kwan on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourCategory.h"

@implementation TRVTourCategory

-(instancetype)initWithName:(NSString *)name cateogoryImage:(UIImage *)cateogoryImage iconImage:(UIImage *)iconImage {
    self = [super init];
    
    if (self) {
        _categoryName = name;
        _categoryImage = cateogoryImage;
        _iconImage = iconImage;
    }
    
    return self;
}


+(TRVTourCategory *)returnSeeCategory {
    return [[TRVTourCategory alloc] initWithName:@"See" cateogoryImage:[UIImage imageNamed:@"beijing.jpg"] iconImage:[UIImage imageNamed:@"seeCategoryIcon"]];
}
+(TRVTourCategory *)returnPlayCategory{
    return  [[TRVTourCategory alloc] initWithName:@"Play" cateogoryImage:[UIImage imageNamed:@"beijing.jpg"] iconImage:[UIImage imageNamed:@"beijing.jpg"]];
}
+(TRVTourCategory *)returnEatCategory {
    return  [[TRVTourCategory alloc] initWithName:@"Eat" cateogoryImage:[UIImage imageNamed:@"london.jpg"] iconImage:[UIImage imageNamed:@"london.jpg"]];
}

+(TRVTourCategory *)returnDrinkCategory {
    return   [[TRVTourCategory alloc] initWithName:@"Drink" cateogoryImage:[UIImage imageNamed:@"leo.jpg"] iconImage:[UIImage imageNamed:@"madrid.jpg"]];
}

@end
