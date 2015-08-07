//
//  TRVCompleteSignupWithFacebookViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVCompleteSignupWithFacebookViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>
@interface TRVCompleteSignupWithFacebookViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *languagesSpokenTextField;
@property (weak, nonatomic) IBOutlet UITextView *bioTextField;
@property (weak, nonatomic) IBOutlet UISwitch *isGuide;
@property (weak, nonatomic) IBOutlet UITextField *oneLineBio;
@property (weak, nonatomic) IBOutlet UISegmentedControl *homeCitySegmentedControl;
@property (nonatomic, strong) NSString *selectedHomeCity;
@end

@implementation TRVCompleteSignupWithFacebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

}





- (IBAction)segmentSelected:(id)sender {
    
    if (self.homeCitySegmentedControl.selectedSegmentIndex == 0){
        
        self.selectedHomeCity = @"New York";
    } else if (self.homeCitySegmentedControl.selectedSegmentIndex == 1){
        
        self.selectedHomeCity = @"Los Angeles";
    } else if (self.homeCitySegmentedControl.selectedSegmentIndex == 2){
        
        self.selectedHomeCity = @"Paris";
    } else if (self.homeCitySegmentedControl.selectedSegmentIndex == 3){
        
        self.selectedHomeCity = @"London";
    } else {
        
        self.selectedHomeCity = @"Unknown";
    }
    
    
}



- (IBAction)doneButtonPressed:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Signing Up!";
        [hud show:YES];
    
    PFUser *currentUser = [PFUser currentUser];
    currentUser[@"userBio"][@"phoneNumber"] = self.phoneNumberTextField.text;
    currentUser[@"userBio"][@"languagesSpoken"] = self.languagesSpokenTextField.text;
    currentUser[@"userBio"][@"bioTextField"] = self.bioTextField.text;
    currentUser[@"userBio"][@"isGuide"] = @(self.isGuide.on);
    currentUser[@"userBio"][@"oneLineBio"] = self.oneLineBio.text;
    currentUser[@"userBio"][@"homeCity"] = self.selectedHomeCity;
    currentUser[@"userBio"][@"user"] = [PFUser currentUser];
  

    
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        [hud hide:YES];
        if (succeeded){
            if (self.isGuide.on){
                // TRANSITION TO GUIDE HOME PAGE
            
                
                
            } else {
                // TRANSITION TO TOURIST HOME PAGE
                // trvtabbar
                UIStoryboard *tourist = [UIStoryboard storyboardWithName:@"TRVTabBar" bundle:nil];
                
                UIViewController *destination = [tourist instantiateInitialViewController];
                
                UIViewController *presentingViewController = self.presentingViewController;
                
               [presentingViewController dismissViewControllerAnimated:NO completion:^{
                   [presentingViewController presentViewController:destination animated:NO completion:nil];
               }];
                
            }
            
        } else {
            NSLog(@"Error saving bio: %@", error);
            UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Error Saving" message:@"Unable to save profile info." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertBox show];
            
        }
        
    }];
    
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
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
