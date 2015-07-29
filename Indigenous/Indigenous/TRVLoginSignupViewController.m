//
//  TRVLoginSignupViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVLoginSignupViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface TRVLoginSignupViewController () <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookLoginButton;
@property (nonatomic, strong) FBSDKProfile *currentFacebookProfile;


@end

@implementation TRVLoginSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.facebookLoginButton.delegate = self;
    self.facebookLoginButton.readPermissions = @[@"email", @"public_profile", @"user_birthday"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginStatusChanged) name:FBSDKProfileDidChangeNotification object:nil];
    
}

-(void)userLoginStatusChanged {
    
    
    self.currentFacebookProfile = [FBSDKProfile currentProfile];
    NSLog(@"Current Profile %@", self.currentFacebookProfile);
    
    // DONT CALL ON MAIN THREAD //
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender, birthday"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (error) {
             NSLog(@"Login error: %@", [error localizedDescription]);
             return;
         }
         
         NSLog(@"fecthed user: %@  email: %@ birthday: %@", result, result[@"email"], result[@"birthday"]);
     }];
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Facebook user logged in.");
    } else {
        NSLog(@"Facebook user not logged in.");
    }
    
}


- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{
    
//    self.currentFacebookProfile = [FBSDKProfile currentProfile];
//    NSLog(@"%@", self.currentFacebookProfile);
    
  
}


- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
    
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
