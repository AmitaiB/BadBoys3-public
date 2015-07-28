//
//  TRVUser.h
//  Indigenous
//
//  Created by Alan Scarpa on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TRVBio.h"

@interface TRVUser : NSObject

@property (nonatomic, strong) TRVBio *userBio;

@property (nonatomic) TRVRating *rating;

@property (nonatomic, strong) NSMutableArray *tripHistory;
@property (nonatomic) BOOL isGuide;

@property (nonatomic, strong) NSMutableArray *tripsLeading;
@property (nonatomic, strong) NSMutableArray *tripsTaking;


@end
