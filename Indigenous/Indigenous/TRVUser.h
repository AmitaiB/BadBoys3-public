//
//  TRVUser.h
//  Indigenous
//
//  Created by Alan Scarpa on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRVUser : NSObject
@property (nonatomic, strong) NSString *userName;

// I think this could be a class
@property (nonatomic, strong) NSString *userBio;

// I think this could be a class
@property (nonatomic) NSUInteger touristRating;
@property (nonatomic) NSUInteger guideRating;

@property (nonatomic, strong) NSMutableArray *tripHistory;
@property (nonatomic) BOOL isGuide;

@property (nonatomic, strong) NSMutableArray *tripsLeading;
@property (nonatomic, strong) NSMutableArray *tripsTaking;


@end
