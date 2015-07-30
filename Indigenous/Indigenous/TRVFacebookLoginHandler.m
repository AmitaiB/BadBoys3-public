//
//  TRVFacebookLoginHandler.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVFacebookLoginHandler.h"

@interface TRVFacebookLoginHandler () <FBSDKLoginButtonDelegate>


@property (strong, nonatomic) FBSDKLoginButton *facebookLoginButton;
@property (nonatomic, strong) FBSDKProfile *currentFacebookProfile;


@end

@implementation TRVFacebookLoginHandler



-(instancetype)initWithButton:(FBSDKLoginButton*)button {
    
    self = [super init];
    if (self){
        _facebookLoginButton = button;
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginStatusChanged) name:FBSDKProfileDidChangeNotification object:nil];
    
    return self;
    
}


-(void)presentHomeStoryboardOnSuccessfulLogin:(void (^)(BOOL success))completion{
    
    
    self.facebookLoginButton.delegate = self;
    self.facebookLoginButton.readPermissions =  @[@"email", @"public_profile", @"user_birthday"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    //login was successful
    self.loginCompletionBlock = completion;
    
    
}

-(void)userLoginStatusChanged{
    
    self.currentFacebookProfile = [FBSDKProfile currentProfile];
    NSLog(@"Current Profile %@", self.currentFacebookProfile);
    
    if (self.currentFacebookProfile){
        
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender, birthday"}]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (error) {
                     NSLog(@"Login error: %@", [error localizedDescription]);
                     return;
                 }
                 
                 //SUCCESS - PRESENT NEXT VIEW
                 self.loginCompletionBlock(YES);
                 self.loginCompletionBlock = nil;
                 NSLog(@"fecthed user: %@  email: %@ birthday: %@", result, result[@"email"], result[@"birthday"]);

             }];
      
        
    }
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{
    
    //    self.currentFacebookProfile = [FBSDKProfile currentProfile];
    //    NSLog(@"%@", self.currentFacebookProfile);
    
    
}


- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
    
    
}

@end
