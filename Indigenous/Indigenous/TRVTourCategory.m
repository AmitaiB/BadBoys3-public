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

-(instancetype)initWithName:(NSString *)name {
    UIImage *emptyImage = [UIImage imageWithCIImage:[CIImage emptyImage]];
    return [self initWithName:name cateogoryImage:emptyImage iconImage:[emptyImage copy]];
}


+(TRVTourCategory *)returnCategoryWithTitle:(NSString *)title {
    if ([title isEqualToString:@"See"]) {
         return [[TRVTourCategory alloc] initWithName:@"See" cateogoryImage:[UIImage imageNamed:@"beijing.jpg"] iconImage:[UIImage imageNamed:@"seeCategoryIcon"]];
    }  else if ([title isEqualToString:@"Play"]) {
         return  [[TRVTourCategory alloc] initWithName:@"Play" cateogoryImage:[UIImage imageNamed:@"beijing.jpg"] iconImage:[UIImage imageNamed:@"beijing.jpg"]];
    }  else if ([title isEqualToString:@"Eat"]) {
        return  [[TRVTourCategory alloc] initWithName:@"Eat" cateogoryImage:[UIImage imageNamed:@"london.jpg"] iconImage:[UIImage imageNamed:@"london.jpg"]];

    }  else if ([title isEqualToString:@"Drink"]) {
        return   [[TRVTourCategory alloc] initWithName:@"Drink" cateogoryImage:[UIImage imageNamed:@"leo.jpg"] iconImage:[UIImage imageNamed:@"madrid.jpg"]];    }
    return nil;
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
