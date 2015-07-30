//
//  TRVLoginViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVLoginViewController.h"
#import "TRVFacebookLoginHandler.h"

@interface TRVLoginViewController ()

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookLoginButton;
@property (nonatomic, strong) TRVFacebookLoginHandler *loginHandler;


@end

@implementation TRVLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFacebookLoginButton];

}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Facebook user logged in");
        [self transitionToHomeStoryboard];
    } else {
        NSLog(@"Facebook user not logged in.");
    }
    
}


-(void)setUpFacebookLoginButton{
    
    self.loginHandler = [[TRVFacebookLoginHandler alloc]initWithButton:self.facebookLoginButton];
    
    [self.loginHandler presentHomeStoryboardOnSuccessfulLogin:^(BOOL success) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"About to transition!");
            [self transitionToHomeStoryboard];
        }];
    }];
    
}


- (IBAction)loginButtonPressed:(id)sender {

    [self transitionToHomeStoryboard];

}


-(void)transitionToHomeStoryboard {
    
    
    
    
    
    
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
