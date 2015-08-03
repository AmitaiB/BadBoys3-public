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
        PFQuery *query = [PFQuery queryWithClassName:@"UserBio"];
        PFObject *object = currentUser[@"userBio"];
        
    // SET EQUAL TO AS LOGGED IN USER
    [query whereKey:@"objectId" equalTo:object.objectId];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            self.parseUserInfo = objects[0];
            NSLog(@"%@????????", objects[0]);
            NSLog(@"This is the response: %@", objects);
            NSLog(@"%@!!!!!!!!",objects[0][@"bioTextField"]);
        }
    }];

        
    // Set properties here
        _firstName = self.parseUserInfo[@"firstName"];
        NSLog(@"%@",self.parseUserInfo[@"firstName"] );
        
        
    }
    
    return self;
}


@end
