//
//  TRVLoginSignupViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVLoginSignupHomeViewController.h"
#import "TRVFacebookLoginHandler.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>

@interface TRVLoginSignupHomeViewController ()



@end

@implementation TRVLoginSignupHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    [PFUser logOut];
//    [FBSDKAccessToken setCurrentAccessToken:nil];
//    [FBSDKProfile setCurrentProfile:nil];


    NSLog(@"PFUSER: %@", [PFUser currentUser]);
    NSLog(@"FACEBOOK USER: %@", [FBSDKAccessToken currentAccessToken]);
    
    
  
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkToSeeIfUserIsLoggedIn];

    
}

-(void)checkToSeeIfUserIsLoggedIn {
    
    if (([FBSDKAccessToken currentAccessToken] && [PFUser currentUser]) || [PFUser currentUser]) {
        
        [self transitionToHome];
        
    } else {
        
        NSLog(@"No one logged in.");

    }

    
    
}



-(void)transitionToHome{
    
    // User is logged in, do work such as go to next view controller.
    NSLog(@"Facebook user logged in");
    PFObject *userBio = [PFUser currentUser][@"userBio"];
    
    
    [userBio fetchInBackgroundWithBlock:^(PFObject *object, NSError *error){
        
        NSNumber *isGuide = userBio[@"isGuide"];
        if ([isGuide isEqualToNumber:@(NO)]){
            [self presentTouristHomeView];
        } else {
            
            //TRANSITION TO GUIDE HOME VIEW
            
        }
        
    }];
    

}


-(void)transitionToHomeStoryboardWithEmail:(NSString*)email andPassword:(NSString*)password{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES]; // start progres hud
    hud.labelText = @"Logging In";
    
    [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error){
        
        
        if (user){
            
            NSLog(@"User: %@", user);
            NSLog(@"bio: %@", user[@"userBio"]);
            PFObject *bioObject = user[@"userBio"];
            
            [bioObject fetchInBackgroundWithBlock:^(PFObject *object, NSError *error){
                [hud hide:YES];
                
                if (object){
                    if ([user[@"userBio"][@"isGuide"] isEqualToNumber:@(YES)]){
                        // present guide home
                        // NEEDS TO GET DONE
                        
                        
                    } else {
                        // present guide home
                        [self presentTouristHomeView];
                        
                    }
                } else {
                    
                    NSLog(@"Unable to log in: %@", error);
                    UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Error Logging In" message:@"Please check your username and password.  Then try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertBox show];
                }
                
                
            }];
            
        } else {
            
            NSLog(@"Unable to log in: %@", error);
            UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Error Logging In" message:@"Please check your username and password.  Then try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertBox show];
            
        }
        
        
    }];
    
    
}


-(void)presentTouristHomeView {
    
    
    UIStoryboard *tourist = [UIStoryboard storyboardWithName:@"TRVTabBar" bundle:nil];
    
    UIViewController *destination = [tourist instantiateInitialViewController];
    
    [self presentViewController:destination animated:YES completion:nil];
    
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
