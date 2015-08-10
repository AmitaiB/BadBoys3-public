//
//  TRVEditProfileViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVEditProfileViewController.h"
#import <Masonry.h>

@interface TRVEditProfileViewController ()

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@end

@implementation TRVEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
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
