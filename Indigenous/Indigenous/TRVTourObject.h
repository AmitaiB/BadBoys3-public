//
//  TRVTourDataPF.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PFObject.h"
//#import <Parse.h>

@interface TRVTourObject : NSObject

@property (strong, nonatomic) NSString       *tourName;
@property (strong, nonatomic) NSArray        *tourCategories;
@property (strong, nonatomic) NSString       *tourCategory;
@property (strong, nonatomic) NSDate         *tourDate;
@property (strong, nonatomic) NSMutableArray *tourItinerary;
@property (strong, nonatomic) UIImage        *tourImage;



@end
