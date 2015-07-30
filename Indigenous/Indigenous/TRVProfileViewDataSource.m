//
//  TRVProfileViewDataSource.m
//  Indigenous
//
//  Created by Leo Kwan on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVProfileViewDataSource.h"
#import "TRVUserSnippetTableViewCell.h"
#import "TRVBio.h"
#import "TRVUser.h"

@interface TRVProfileViewDataSource()
@property (nonatomic, strong) TRVUser *currentUser;
@end

@implementation TRVProfileViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    self.currentUser = [[TRVUser alloc] init];

    self.currentUser.userBio = [[TRVBio alloc] initTouristWithUserName:@"leo" firstName:@"Leo" lastName:@"Kwan" email:@"leokwanbt14@gmail.com" phoneNumber:7188866958 profileImage:[UIImage imageNamed:@"leo.jpg"] bioDescription:@"great person" interests:[NSMutableArray arrayWithObjects:@"hi", @"hi", nil] language:@"English"];
    

    
    
    if(indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileImageCell"];
        return cell;
    }
    else if (indexPath.row == 1) {
        TRVUserSnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoSnippetCell"];
        cell.user = self.currentUser;
        return cell;
    }
    
    return nil;
}



@end
