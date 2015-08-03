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


@end
