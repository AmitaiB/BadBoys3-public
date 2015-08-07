//
//  TRVProfileViewController.m
//  Indigenous

#import <Masonry.h>

#import "TRVProfileViewController.h"
#import "TRVUserSnippetView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import "TRVUserProfileImageView.h"
#import "TRVUserDataStore.h"


@interface TRVProfileViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;


@end

@implementation TRVProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    self.user = self.sharedDataStore.loggedInUser;
    

    
    //Instantiate a Image View Nib
    
        TRVUserProfileImageView *profileImageView = [[TRVUserProfileImageView alloc] init];
        
    
        profileImageView.userForThisProfileImageView = self.sharedDataStore.loggedInUser;
        [self.containerView addSubview:profileImageView];
        
        [profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(self.containerView);
            make.height.equalTo(self.containerView.mas_width);
        }];
    
    
    //Instantiate a Snippet View Nib

        TRVUserSnippetView *snippetView = [[TRVUserSnippetView alloc] init];
        snippetView.userForThisSnippetView = self.user;
        [self.containerView addSubview:snippetView];

        [snippetView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.top.equalTo(profileImageView.mas_bottom);
            make.left.and.right.equalTo(self.containerView);
            

        }];
    
    //Instantiate an ABOUT ME  Nib
    
    TRVUserAboutMeView *aboutMeView = [[TRVUserAboutMeView alloc] init];
    aboutMeView.userForThisAboutMeView = self.user;
    [self.containerView addSubview:aboutMeView];
    [aboutMeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(snippetView.mas_bottom);
        make.left.and.right.equalTo(self.containerView);

    }];

    
    
    //Instantiate a Contact View Nib

        TRVUserContactView *contactView = [[TRVUserContactView alloc] init];
        contactView.userForThisContactView = self.user;
        [self.containerView addSubview:contactView];
        [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(aboutMeView.mas_bottom);
            make.left.and.right.equalTo(self.containerView);
        }];
    
    // Set Container View Constraints
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(contactView.mas_bottom);
//        make.height.equalTo(contactView.mas_c);
    }];
    
    
    
    
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
