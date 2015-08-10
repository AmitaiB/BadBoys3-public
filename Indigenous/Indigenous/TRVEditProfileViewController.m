//
//  TRVEditProfileViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVEditProfileViewController.h"
#import "TRVEditProfileView.h"
#import <Masonry.h>

@interface TRVEditProfileViewController ()

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) TRVEditProfileView *editProfileNib;
@end

@implementation TRVEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.scrollView.mas_width);
    }];
    
    
    self.editProfileNib = [[TRVEditProfileView alloc] init];
    [self.contentView addSubview:self.editProfileNib];
    

    [self.editProfileNib mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
        make.width.equalTo(self.contentView.mas_width);
        make.left.and.right.and.top.equalTo(self.contentView);
        make.height.equalTo(@1000);
    }];
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.editProfileNib.mas_bottom);
        make.width.equalTo(self.scrollView.mas_width);
    }];
    
//    // Do any additional setup after loading the view.
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
