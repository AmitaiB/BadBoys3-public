//
//  TRVAddTourLocalData_PF.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/16/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "PFObject.h"
#import <PFObject+Subclass.h>

@interface TRVLocalTourData_PF : PFObject <PFSubclassing>
+ (NSString *)parseClassName;

/**
 *  "Staging Area" properties. When these are ready to go,
 *  they will populate the correct fields before uploading
 *  and saving to the Backend.
 */
@property (strong, nonatomic) NSString *tourNameString;
@property (strong, nonatomic) NSString *tourCategoryString;
@property (strong, nonatomic) NSDate *depatureDate;
@property (strong, nonatomic) NSMutableArray *tourStopCoordinatesArray;


@end
