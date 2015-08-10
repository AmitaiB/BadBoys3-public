//
//  TRVEditProfileTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//


#import "TRVEditProfileTableViewController.h"
#import "TRVEditProfileView.h"
#import "TRVUserDataStore.h"
#import <Masonry.h>

@interface TRVEditProfileTableViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *aboutMeContentView;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *testCell;
@property (nonatomic, strong) TRVEditProfileView *editProfileNib;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@end

@implementation TRVEditProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
//    [self.taglineLabel sizeToFit];
    self.firstNameTextField.text = self.sharedDataStore.loggedInUser.userBio.firstName;
    NSLog(@"%@", self.sharedDataStore.loggedInUser.userBio.firstName);
    [self.testCell.contentView addSubview:self.editProfileNib];
    // set constraints for tour nib
    [self.editProfileNib mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testCell).with.offset(10);
        make.left.equalTo(self.testCell).with.offset(5);
        make.right.equalTo(self.testCell).with.offset(-5);
        make.bottom.equalTo(self.testCell.mas_bottomMargin).with.offset(10);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}

//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // set height of first row
//    if (indexPath.row == 0) {
//        return 300;
//    }
//    return 50;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
