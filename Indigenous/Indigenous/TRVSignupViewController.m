//
//  TRVSignupViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVSignupViewController.h"
#import "TRVFacebookLoginHandler.h"


@interface TRVSignupViewController ()
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookLoginButton;
@property (nonatomic, strong) TRVFacebookLoginHandler *loginHandler;


@end

@implementation TRVSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFacebookSignupButton];
}


-(void)setUpFacebookSignupButton{
    
    self.loginHandler = [[TRVFacebookLoginHandler alloc]initSignupWithButton:self.facebookLoginButton];
    
    [self.loginHandler loginToFacebook:^(BOOL success, NSNumber *facebookID) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"Email: %@ \nAbout to transition!", facebookID);
            [self transitionToCompleteProfileViewWithFacebookID:facebookID];
        }];
    }];
    
}


-(void)transitionToCompleteProfileViewWithFacebookID:(NSNumber*)facebookID {
    
    
    
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
