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
@property (weak, nonatomic) IBOutlet TRVTourCategoryView *testView;
- (IBAction)changeImage:(id)sender;

@end

@implementation TRVTourCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make self as datasource and delegate
    self.categoryCollectionView.delegate =self;
    self.categoryCollectionView.dataSource = self;
    
    
    // Instantiate a category view and category
//    
//    TRVTourCategory *playCategory = [[TRVTourCategory alloc] initWithName:@"See" cateogoryImage:[UIImage imageNamed:@"seeCategory.jpg"] iconImage:[UIImage imageNamed:@"seeCategory.jpg"]];
//    
//    
//    [self.testView setCategoryForThisView:playCategory];
    
    self.tourCategoryViews = @[self.testView,self.testView, self.testView];

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return array count
    return self.tourCategoryViews.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TRVTourCategoryCollectionViewCell *cell = (TRVTourCategoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"tourCategoryCollectionCell" forIndexPath:indexPath];
 
    TRVTourCategory *playCategory = [[TRVTourCategory alloc] initWithName:@"See" cateogoryImage:[UIImage imageNamed:@"seeCategory.jpg"] iconImage:[UIImage imageNamed:@"seeCategory.jpg"]];

    [cell.testView setCategoryForThisView:playCategory];

    
    TRVTourCategoryView *categoryViewForThisCell = [self.tourCategoryViews objectAtIndex:indexPath.row];
    
    cell.testView = categoryViewForThisCell.categoryContentView;
    
    
    return cell;
}





-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
    
    NSLog(@"Are you in here?");
    [self performSegueWithIdentifier:@"showResultsSegue" sender:nil];
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSArray *ip = [self.categoryCollectionView indexPathsForSelectedItems];
    
    if([segue.identifier isEqualToString:@"entrySegue"]) {
        
       /// pass over filters..
        
    }
         
}


- (IBAction)changeImage:(id)sender {
    self.testView.categoryImageView.image = [UIImage imageNamed:@"london.jpg"];
    self.testView.categoryNameLabel.text = @"YOOOOOOOOO";
    
    
}
@end
