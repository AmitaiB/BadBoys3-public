//
//  TRVDetailGuideViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/5/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVDetailGuideViewController.h"
#import "TRVUser.h"
#import "TRVUserSnippetView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import "TRVUserProfileImageView.h"

#import "TRVUserDataStore.h"
#import <Masonry.h>

@interface TRVDetailGuideViewController ()


@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;


@end

@implementation TRVDetailGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    
    
    //Instantiate a Image View Nib
    
    TRVUserProfileImageView *profileImageView = [[TRVUserProfileImageView alloc] init];
    profileImageView.userForThisProfileImageView = self.selectedGuideUser;
    
    [self.profileView addSubview:profileImageView];
    [profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.profileView);
        make.height.equalTo(self.profileView.mas_width);
    }];
    
    
    //Instantiate a Snippet View Nib
    
    TRVUserSnippetView *snippetView = [[TRVUserSnippetView alloc] init];
    snippetView.userForThisSnippetView = self.selectedGuideUser;
    
    
    [self.profileView addSubview:snippetView];
    [snippetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileImageView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
    }];
    
    //Instantiate an ABOUT ME  Nib
    
    TRVUserAboutMeView *aboutMeView = [[TRVUserAboutMeView alloc] init];
    aboutMeView.userForThisAboutMeView = self.selectedGuideUser;
    
    [self.profileView addSubview:aboutMeView];
    [aboutMeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(snippetView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
        
    }];
    
    
    
    //Instantiate a Contact View Nib
    
    TRVUserContactView *contactView = [[TRVUserContactView alloc] init];
    contactView.userForThisContactView = self.selectedGuideUser;
    
    [self.profileView addSubview:contactView];
    [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aboutMeView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
    }];
    
    // Set Container View Constraints
    
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(contactView.mas_bottom);
    }];
    
    

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
