//
//  TRVTourGuideMyToursVC.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourGuideMyToursVC.h"
#import <FBSDKProfile.h>
#import <UIKit+AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@interface TRVTourGuideMyToursVC ()
    //The profile
@property (weak, nonatomic) IBOutlet UIButton *profileImageButton;
- (IBAction)profileImageButtonTapped:(id)sender;

@end

@implementation TRVTourGuideMyToursVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  FBProfile → UserID → pic URL → setImageWithURL (ty UIImage+AFNetworking) = Profile Pic
     **************************************************************************************/
    FBSDKProfile *currentProfile_FB = [FBSDKProfile currentProfile];
    NSURL *avatarURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture", currentProfile_FB.userID]];
    UIImageView *profileImageView = [UIImageView new];
    [profileImageView setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"laughingSalad"]];
    self.profileImageButton.imageView.image = profileImageView.image;
        ///************************************************************************
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

- (IBAction)profileImageButtonTapped:(id)sender {
    
}
@end
