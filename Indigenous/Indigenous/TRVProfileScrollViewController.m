//
//  TRVProfileScrollViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVProfileScrollViewController.h"
#import <Masonry.h>
#import "TRVUserSnippetView.h"
#import "TRVUserContactView.h"


@interface TRVProfileScrollViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet TRVUserSnippetView *profileSnippetView;



@end

@implementation TRVProfileScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [[TRVUser alloc] init];
    
    self.user.userBio = [[TRVBio alloc] initTouristWithUserName:@"Ashley" firstName:@"Ashley" lastName:@"Madison" email:@"ashleyfromthe6@gmail.com" phoneNumber:7188866958 profileImage:[UIImage imageNamed:@"leo.jpg"] bioDescription:@"great person" interests:[NSMutableArray arrayWithObjects:@"hi", @"hi", nil] language:@"English"];
    self.user.userBio.homeCity = @"New York";
    self.user.userBio.homeCountry = @"United States";
    self.user.userBio.userTagline = @"Loves fried chicken and ramen. Super Spontaneous Person!";
    self.user.userBio.profileImage = [UIImage imageNamed:@"leo.jpg"];

    
    
    // Do any additional setup after loading the view.
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.scrollView.mas_width);
        
        make.height.equalTo(@2000);
    }];
    
    
    
    [self.profileSnippetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.containerView.mas_right);
        
        make.height.equalTo(@100);
        NSLog(@"are you in here?? masonry");
    }];
    self.profileSnippetView.userForThisSnippetView = self.user;
    
    
    TRVUserContactView *contactView = [[TRVUserContactView alloc] init];
    contactView.userForThisContactView = self.user;
    [self.containerView addSubview:contactView];
//    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@806);
        make.top.equalTo(self.profileSnippetView.mas_bottom);
        make.left.and.right.equalTo(self.containerView);
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
