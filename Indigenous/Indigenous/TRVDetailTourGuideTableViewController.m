//
//  TRVDetailTourGuideTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVDetailTourGuideTableViewController.h"
#import "TRVProfileImageTableViewCell.h"
#import "TRVProfileViewDataSource.h"
#import "TRVUserSnippetTableViewCell.h"
#import "TRVContactTableViewCell.h"
#import "TRVBio.h"

@interface TRVDetailTourGuideTableViewController ()


@end

@implementation TRVDetailTourGuideTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // this makes custom cell masonry height properties work
    self.tableView.estimatedRowHeight = 300;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.user = [[TRVUser alloc] init];
    
    self.user.userBio = [[TRVBio alloc] initTouristWithUserName:@"Ashley" firstName:@"Ashley" lastName:@"Madison" email:@"ashleyfromthe6@gmail.com" phoneNumber:7188866958 profileImage:[UIImage imageNamed:@"leo.jpg"] bioDescription:@"great person" interests:[NSMutableArray arrayWithObjects:@"hi", @"hi", nil] language:@"English"];
    self.user.userBio.homeCity = @"New York";
    self.user.userBio.homeCountry = @"United States";
    self.user.userBio.userTagline = @"Loves fried chicken and ramen. Super Spontaneous Person!";
    self.user.userBio.profileImage = [UIImage imageNamed:@"leo.jpg"];
    
    
    
    if(indexPath.row == 0) {
        TRVProfileImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileImageCell"];
        cell.userForThisImageCell = self.user;
        return cell;
    }
    else if(indexPath.row == 1) {
        TRVUserSnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"snippet"];
        cell.user = self.user;
        return cell;
    }
    else if(indexPath.row == 2) {
        TRVContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
        cell.userForThisContactCell = self.user;
        return cell;
    }

    
    return nil;
   }


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
