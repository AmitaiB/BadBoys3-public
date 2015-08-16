//
//  TRVTour_PF.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/16/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "PFObject.h"
#import <Parse.h>
#import "TRVTourCategory_PF.h"

@interface TRVTour_PF : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString           *tourName;
@property (strong, nonatomic) TRVTourCategory_PF *tourCategory;
@property (strong, nonatomic) NSDate             *depatureDate;
@property (strong, nonatomic) NSMutableArray     *tourStopGeoPoints;

+ (NSString *)parseClassName;


@end
