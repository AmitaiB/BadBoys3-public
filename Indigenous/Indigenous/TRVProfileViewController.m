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
#import "TRVProfileViewDataSource.h"

@interface TRVProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (nonatomic, strong) TRVProfileViewDataSource *tableViewDataSource;


@end

@implementation TRVProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewDataSource = [[TRVProfileViewDataSource alloc] init];

    self.profileTableView.dataSource = self.tableViewDataSource;
    
       // Do any additional setup after loading the view.
}


//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return 2;
//}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    if(indexPath.row == 0) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileImageCell"];
//        return cell;
//    }
//    else if (indexPath.row == 1) {
//           TRVUserSnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoSnippetCell"];
//               return cell;
//    }
//
//    return nil;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
