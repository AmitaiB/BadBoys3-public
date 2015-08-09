//
//  TRVDetailGuideViewController.m
//  Indigenous
//



#import "TRVDetailGuideViewController.h"

#import "TRVDetailGuideAllTripsDataSource.h"

#import "TRVUserDataStore.h"
#import "TRVTouristTripTableViewCell.h"
#import "NSMutableArray+extraMethods.h"
#import "TRVUser.h"
#import "TRVTourStop.h"

// COCOAPODS
#import <Masonry.h>

// NIBS
#import "TRVUserSnippetView.h"
#import "TRVTourView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import "TRVUserProfileImageView.h"




@interface TRVDetailGuideViewController ()<UITableViewDelegate>


@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (nonatomic, strong) UITableView *guideTripsTableView;
@property (nonatomic, strong) TRVDetailGuideAllTripsDataSource *tableViewDataSource;

@end

@implementation TRVDetailGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];

    NSLog(@"%@", self.selectedGuideUser.allTrips);
    
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

    // hide send me to tourguidetab button
        [aboutMeView.switchToGuideButton setHidden:YES];
    //make button shrink
        [aboutMeView.switchToGuideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0);
    }];

    
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
    
    //    Instantiate a Segmented Control View
    
    
    // SET THE TAB BAR TO CATEGORY SEARCH
    TRVTourCategory *categoryForFirstTab = self.sharedDataStore.currentCategorySearching;
    NSString *categorySearchTabName = categoryForFirstTab.categoryName;
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:categorySearchTabName, @"Other Tours", nil]];
    segmentedControl.frame = CGRectMake(35, 200, 250, 50);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents: UIControlEventValueChanged];
    
    
    [self.profileView addSubview:segmentedControl];

    // Segmented Control Constraints
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contactView.mas_bottom).with.offset(10);
        make.left.equalTo(self.profileView).with.offset(10);
        make.right.equalTo(self.profileView).with.offset(-10);
    }];

    
//    Instantiate a Table View

    self.guideTripsTableView = [[UITableView alloc] init];
    [self.profileView addSubview:self.guideTripsTableView];
 
    
    // Register cell
        [self.guideTripsTableView registerClass:[TRVTouristTripTableViewCell class] forCellReuseIdentifier:@"tripCell"];
        
        self.guideTripsTableView.backgroundColor = [UIColor orangeColor];
    
    // Set Table View Constraints
    [self.guideTripsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentedControl.mas_bottom).with.offset(10);
        make.left.and.right.equalTo(self.profileView);
        NSUInteger numberOfCells = self.selectedGuideUser.allTrips.count;

        // hacky way to make table view longer
        NSNumber *cellHeight = @(320);
        NSNumber *tableViewHeight = @([cellHeight floatValue] * numberOfCells);
        make.height.equalTo(tableViewHeight);
        }];
    
    
    // Set Content View Constraints
    
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        //Add padding to bottom of VC
        make.bottom.equalTo(self.guideTripsTableView.mas_bottom).with.offset(10);
    }];
    
    
    // set delegate and datasource owner
        self.guideTripsTableView.delegate = self;
        self.tableViewDataSource = [[TRVDetailGuideAllTripsDataSource alloc] initWithTrips:self.selectedGuideUser.allTrips];
        self.guideTripsTableView.dataSource = self.tableViewDataSource;
    }



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

- (void)segmentedControlChanged:(UISegmentedControl *)segment
{
        NSLog(@"DO YOU GET CALLED SEGMENTED CONTROL?");
        [self.tableViewDataSource changeTripsDisplayed];
        [self.guideTripsTableView reloadData];

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
