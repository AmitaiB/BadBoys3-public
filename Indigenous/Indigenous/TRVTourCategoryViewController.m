//
//  TRVTourCategoryViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourCategoryViewController.h"
#import "TRVTourCategoryCollectionViewCell.h"
#import "TRVTourCategoryView.h"

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
    
    
    // Instantiate a category view and category
    
        TRVTourCategory *playCategory = [[TRVTourCategory alloc] initWithName:@"See" cateogoryImage:[UIImage imageNamed:@"seeCategory.jpg"] iconImage:[UIImage imageNamed:@"seeCategory.jpg"]];
    
    // Instantiate a category view and category
        TRVTourCategoryView *playCategoryView = [[TRVTourCategoryView alloc] init];
        playCategoryView.categoryForThisView = playCategory;
        
        self.tourCategoryViews = @[playCategoryView,playCategoryView,playCategoryView];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    
    //return array count
    
    return self.tourCategoryViews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TRVTourCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tourCategoryCollectionCell" forIndexPath:indexPath];
    
    TRVTourCategoryView *categoryViewForThisCell = [self.tourCategoryViews objectAtIndex:indexPath.row];
    UIView *contentViewForThisCell = categoryViewForThisCell.categoryContentView;
    //    UIImage *categoryImageForThisCell = categoryViewForThisCell.categoryForThisView.categoryImage;
    
    cell.categoryViewForThisCell = contentViewForThisCell;

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
