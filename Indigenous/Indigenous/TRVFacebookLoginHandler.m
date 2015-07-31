//
//  TRVFacebookLoginHandler.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVFacebookLoginHandler.h"
#import "TRVUserSignupHandler.h"

@interface TRVFacebookLoginHandler () <FBSDKLoginButtonDelegate>


@property (strong, nonatomic) FBSDKLoginButton *facebookLoginButton;
@property (nonatomic, strong) FBSDKProfile *currentFacebookProfile;


@end

@implementation TRVFacebookLoginHandler



-(instancetype)initLoginWithButton:(FBSDKLoginButton*)button {
    
    self = [super init];
    if (self){
        _facebookLoginButton = button;
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginStatusChanged) name:FBSDKProfileDidChangeNotification object:nil];
    
    return self;
    
}


-(instancetype)initSignupWithButton:(FBSDKLoginButton*)button {
    
    self = [super init];
    if (self){
        _facebookLoginButton = button;
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userSignupStatusChanged) name:FBSDKProfileDidChangeNotification object:nil];
    
    return self;
    
}

-(void)loginToFacebook:(void (^)(BOOL success, NSNumber *facebookID))completion{
    
    
    self.facebookLoginButton.delegate = self;
    self.facebookLoginButton.readPermissions =  @[@"email", @"public_profile", @"user_birthday"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    //login was successful
    self.loginCompletionBlock = completion;
    
    
}

-(void)userSignupStatusChanged{
    
    self.currentFacebookProfile = [FBSDKProfile currentProfile];
    NSLog(@"Current Profile %@", self.currentFacebookProfile);
    
    if (self.currentFacebookProfile){
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.width(540).height(540), email, name, id, gender, birthday"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (error) {
                 NSLog(@"Login error: %@", [error localizedDescription]);
                 return;
             }
             
             
              NSLog(@"fecthed user: %@  email: %@ birthday: %@, profilePhotoURL: %@", result, result[@"email"], result[@"birthday"], result[@"picture"][@"data"][@"url"]);
             
             [TRVUserSignupHandler addUserToParse:result withCompletion:^(BOOL success, NSError *error) {
                 if (success){
                     self.loginCompletionBlock(YES, result[@"id"]);
                     // TODO: do we need to nil out this block property? Is there a retain cycle between this handler & the VC?
                     //self.loginCompletionBlock = nil;
                     return;
                 }
                 NSLog(@"Error adding user to parse: %@", error);
             }];
            
             
            
             
         }];
        
        
    }
    
    
}


-(void)userLoginStatusChanged{
    
    self.currentFacebookProfile = [FBSDKProfile currentProfile];
    NSLog(@"Current Profile %@", self.currentFacebookProfile);
    
    if (self.currentFacebookProfile){
        
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email"}]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (error) {
                     NSLog(@"Login error: %@", [error localizedDescription]);
                     return;
                 }
                 
                 //SUCCESS - PRESENT NEXT VIEW
                 self.loginCompletionBlock(YES, result[@"id"]);
                 // TODO: do we need to nil out this block property? Is there a retain cycle between this handler & the VC?
                 //self.loginCompletionBlock = nil;
                 NSLog(@"fecthed user email: %@",result[@"email"]);

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
