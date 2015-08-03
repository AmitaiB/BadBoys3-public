//
//  TRVTourCategoryViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourCategoryViewController.h"
#import "TRVTourCategoryCollectionViewCell.h"

@interface TRVTourCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (nonatomic, strong) NSArray *tourCategoryViews;

@end

@implementation TRVTourCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make self as datasource and delegate
    self.categoryCollectionView.delegate =self;
    self.categoryCollectionView.dataSource = self;
    
    self.tourCategoryViews = @[@"newyork.jpg",@"beijing.jpg"];
    
    
    [self.view addSubview:self.categoryCollectionView];

    
    
    // Register cell classes
    [self.categoryCollectionView registerClass:[TRVTourCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"tourCategoryCollectionCell"];
    // Do any additional setup after loading the view.
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

#pragma mark - collection view data source methods


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tourCategoryViews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TRVTourCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tourCategoryCollectionCell" forIndexPath:indexPath];
    
    cell.categoryImageView.image = [UIImage imageNamed:[self.tourCategoryViews objectAtIndex:indexPath.row]];
    cell.categoryImageView.backgroundColor = [UIColor greenColor];
    return cell;
}


@end
