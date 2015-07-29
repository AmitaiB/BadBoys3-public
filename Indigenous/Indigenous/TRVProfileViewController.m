//
//  TRVProfileViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVProfileViewController.h"
#import "TRVUser.h"
#import "TRVBio.h"
#import "TRVUserSnippetTableViewCell.h"

@interface TRVProfileViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (nonatomic, strong) TRVBio *currentBio;

@end

@implementation TRVProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileTableView.delegate = self;
    self.profileTableView.dataSource = self;
    
    
    
     self.currentBio = [[TRVBio alloc] initTouristWithUserName:@"leo" firstName:@"Leo" lastName:@"Kwan" email:@"leokwanbt14@gmail.com" phoneNumber:7188866958 profileImage:[UIImage imageNamed:@"leo.jpg"] bioDescription:@"great person" interests:[NSMutableArray arrayWithObjects:@"hi", @"hi", nil] language:@"English"];
    
    TRVUser *currentUser = [[TRVUser alloc] init];
    currentUser.userBio = self.currentBio;
    
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileImageCell"];
        return cell;
    }
    else if (indexPath.row == 1) {
           TRVUserSnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoSnippetCell"];
        cell.nameLabel.text = self.currentBio.firstName;
        cell.emailLabel.text = self.currentBio.email;
        return cell;
    }

    return nil;
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
