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
#import <Masonry.h>

@interface TRVTourCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (nonatomic, strong) NSMutableArray *tourCategories;

@end

@implementation TRVTourCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make self as datasource and delegate
    self.categoryCollectionView.delegate =self;
    self.categoryCollectionView.dataSource = self;
    
    
    // Instantiate a category view and category
    
    TRVTourCategory *seeCategory = [[TRVTourCategory alloc] initWithName:@"See" cateogoryImage:[UIImage imageNamed:@"seeCategory.jpg"] iconImage:[UIImage imageNamed:@"seeCategory.jpg"]];
    
    TRVTourCategory *playCategory = [[TRVTourCategory alloc] initWithName:@"Play" cateogoryImage:[UIImage imageNamed:@"seeCategory.jpg"] iconImage:[UIImage imageNamed:@"beijing.jpg"]];
    
    TRVTourCategory *eatCategory = [[TRVTourCategory alloc] initWithName:@"Eat" cateogoryImage:[UIImage imageNamed:@"london.jpg"] iconImage:[UIImage imageNamed:@"london.jpg"]];
    
    TRVTourCategory *feelCategory = [[TRVTourCategory alloc] initWithName:@"Feel" cateogoryImage:[UIImage imageNamed:@"leo.jpg"] iconImage:[UIImage imageNamed:@"madrid"]];

    

    self.tourCategories = [@[seeCategory, playCategory, eatCategory, feelCategory] mutableCopy];

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return array count
    return self.tourCategories.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TRVTourCategoryCollectionViewCell *cell = (TRVTourCategoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"tourCategoryCollectionCell" forIndexPath:indexPath];
 

    TRVTourCategory *categoryForThisCell = [self.tourCategories objectAtIndex:indexPath.row];
    
    
    [cell.categoryView setCategoryForThisView:categoryForThisCell];
    [cell.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(@10);
        make.edges.equalTo(@0);
    }];
    
    
    return cell;
}





-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
    
    NSLog(@"Are you in here?");
    [self performSegueWithIdentifier:@"showResultsSegue" sender:nil];
}


#pragma mark - UICollectionViewLayout

// Set size of collection cell
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(175, 175);
}

// set vertical seperation of cell
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8.0;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    NSArray *ip = [self.categoryCollectionView indexPathsForSelectedItems];
    
    if([segue.identifier isEqualToString:@"entrySegue"]) {
        
       /// pass over filters..
        
    }
         
}

@end
