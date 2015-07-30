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

@end
