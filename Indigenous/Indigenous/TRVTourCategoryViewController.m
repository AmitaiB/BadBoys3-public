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
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.tourCategoryViews.count;
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TRVTourCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tourCategoryCollectionCell" forIndexPath:indexPath];
    
//    cell.categoryImageView.image = [UIImage imageNamed:[self.tourCategoryViews objectAtIndex:indexPath.row]];
    cell.categoryImageView.backgroundColor = [UIColor greenColor];

    return cell;
}

#pragma mark - UICollectionViewLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8.0;
    
    // NOT WORKING?
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8.0;
}



@end
