//
//  TRVUserSignupHandler.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserSignupHandler.h"
#import <Parse/Parse.h>

@implementation TRVUserSignupHandler


+(void)addUserToParse:(NSDictionary*)userDetails withCompletion:(void (^)(BOOL success, NSError *error))completion {
    
  
    
    PFUser *newUser = [PFUser new];
    newUser.username = userDetails[@"id"];
    newUser.password = userDetails[@"id"];
    newUser.email = userDetails[@"email"];
    newUser[@"facebookID"] = userDetails[@"id"];
    
    PFObject *userBio = [PFObject objectWithClassName:@"UserBio"];
    [userBio setValuesForKeysWithDictionary:userDetails];
    userBio[@"user"] = [PFUser currentUser];
    
    [newUser setObject:userBio forKey:@"userBio"];
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        
        if (succeeded){
            
            NSLog(@"Successfully signed up user to Parse!");
            
            
        } else {
            NSLog(@"Error signing up: %@", error);
            if (error.code == 200){
                NSLog(@"Missing username!");
                UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Invalid Username" message:@"Please enter a valid username" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertBox show];
                return;
            }
            else if (error.code == 202){
                NSLog(@"Username already taken!");
                UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Username already taken" message:@"Please try a different username" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertBox show];
                return;
            } else if (error.code == 203){
                NSLog(@"Email already taken!");
                UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Email already in use" message:@"Please enter a different email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertBox show];
                return;
            }
            
        }
        
    }];
}



@end
