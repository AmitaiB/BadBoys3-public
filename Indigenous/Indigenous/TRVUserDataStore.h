//
//  TRVUserDataStore.h
//  Indigenous
//
//  Created by Leo Kwan on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRVUser.h"
#import "TRVBio.h"
#import <Parse.h>

@interface TRVUserDataStore : NSObject

+(instancetype)sharedUserInfoDataStore;
-(instancetype) initWithCurrentUser:(PFUser *)currentUser;

@property (nonatomic, strong) PFUser *loggedInUser;
@property (nonatomic, strong) TRVUser *user;
@property (nonatomic, strong) TRVBio *bioForLoggedInUser;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *bioTextField;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSMutableArray *languagesSpoken;
@property (nonatomic) BOOL isGuide;


// SET WHEN EAT/DRINK/PLAY/SEE IS SELECTED
@property (nonatomic, strong) NSString *currentCategorySearching;


@end
