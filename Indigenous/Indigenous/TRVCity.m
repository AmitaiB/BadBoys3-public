//
//  TRVCity.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVCity.h"

@implementation TRVCity


-(instancetype)initWithName:(NSString *)name image:(UIImage *)image {

    self = [super init];
    
    if (self) {
        _nameOfCity = name;
        _cityImage = image;
    }
    
    return self;
}


@end
