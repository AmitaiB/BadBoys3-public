//
//  TRVUserDataStore.m
//  Indigenous
//
//  Created by Leo Kwan on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserDataStore.h"
#import <Parse.h>

@interface TRVUserDataStore()
@property (nonatomic, strong) NSDictionary *parseUserInfo;

@end

@implementation TRVUserDataStore


+ (instancetype)sharedUserInfoDataStore {
    static TRVUserDataStore *_sharedTasksDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTasksDataStore = [[TRVUserDataStore alloc] init];
    });
    
    return _sharedTasksDataStore;
}

-(instancetype) initWithCurrentUser:(PFUser *)currentUser {
   
    self = [super init];
    
    
    
    if (self) {
    
        _parseUser = currentUser;
        
        PFQuery *query = [PFQuery queryWithClassName:@"UserBio"];
        PFObject *object = currentUser[@"userBio"];
        
    // SET EQUAL TO AS LOGGED IN USER
    [query whereKey:@"objectId" equalTo:object.objectId];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            
        
            TRVBio *bioForLoggedInUser = [[TRVBio alloc] init];
            bioForLoggedInUser.firstName = objects[0][@"first_name"];
            bioForLoggedInUser.lastName = objects[0][@"last_name"];
            bioForLoggedInUser.birthday = objects[0][@"birthday"];
            bioForLoggedInUser.email = objects[0][@"email"];
            bioForLoggedInUser.homeCity = @"";
            bioForLoggedInUser.homeCountry = @"";
            bioForLoggedInUser.isGuide = objects[0][@"isGuide"];
            bioForLoggedInUser.language = objects[0][@"languagesSpoken"];
            bioForLoggedInUser.userTagline = objects[0][@"oneLineBio"];
            bioForLoggedInUser.bioDescription = objects[0][@"bioTextField"];
            bioForLoggedInUser.profileImage = objects[0][@"picture"];

            
            
            
            NSLog(@"Welcome %@. ", bioForLoggedInUser.firstName);
         
        }
    }];
    }
    
    return self;
}


@end
