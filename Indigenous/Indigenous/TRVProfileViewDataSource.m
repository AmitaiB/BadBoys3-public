//
//  TRVProfileViewDataSource.m
//  Indigenous
//
//  Created by Leo Kwan on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVProfileViewDataSource.h"
#import "TRVUserSnippetTableViewCell.h"
#import "TRVProfileImageTableViewCell.h"
#import "TRVBio.h"
#import "TRVUser.h"

@interface TRVProfileViewDataSource()
@end

@implementation TRVProfileViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    // Create an instance of current user and user bio
    self.user = [[TRVUser alloc] init];

    self.user.userBio = [[TRVBio alloc] initTouristWithUserName:@"leo" firstName:@"Leo" lastName:@"Kwan" email:@"leokwanbt14@gmail.com" phoneNumber:7188866958 profileImage:[UIImage imageNamed:@"leo.jpg"] bioDescription:@"great person" interests:[NSMutableArray arrayWithObjects:@"hi", @"hi", nil] language:@"English"];
    self.user.userBio.homeCity = @"New York";
    self.user.userBio.homeCountry = @"United States";
    self.user.userBio.userTagline = @"Loves fried chicken and ramen. Super Spontaneous Person!";
    self.user.userBio.profileImage = [UIImage imageNamed:@"leo.jpg"];
    
    
    // Profile Picture Cell
    if(indexPath.row == 0) {
        TRVProfileImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileImageCell"];
        cell.userForThisImageCell = self.user;
        return cell;
    }
    // User Snippet Cell
    else if (indexPath.row == 1) {
        TRVUserSnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoSnippetCell"];
        cell.user = self.user;
        return cell;
    }
    
    return nil;
}



@end
