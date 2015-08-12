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
#import "TRVUserDataStore.h"
#import "TRVGuideResultsTableViewController.h"


@interface TRVTourCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (nonatomic, strong) NSMutableArray *tourCategories;
@property (nonatomic, strong) TRVUserDataStore *dataStore;

@end

@implementation TRVTourCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataStore = [TRVUserDataStore sharedUserInfoDataStore];

    // make self as datasource and delegate
    self.categoryCollectionView.delegate =self;
    self.categoryCollectionView.dataSource = self;


//    self.tourCategories = [@[seeCategory, playCategory, eatCategory, drinkCategory] mutableCopy];
    self.tourCategories = [[NSMutableArray alloc] initWithObjects:[TRVTourCategory returnCategoryWithTitle:@"See"],
                                                                                                                [TRVTourCategory returnCategoryWithTitle:@"Play"],
                                                                                                                [TRVTourCategory returnCategoryWithTitle:@"Eat"],
                                                                                                                [TRVTourCategory returnCategoryWithTitle:@"Drink"], nil];
    
    NSLog(@"Selected city is: %@", self.selectedCity);

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return array count
    return self.tourCategories.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TRVTourCategoryCollectionViewCell *cell = (TRVTourCategoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"tourCategoryCollectionCell" forIndexPath:indexPath];
    TRVTourCategory *categoryForThisCell = [self.tourCategories objectAtIndex:indexPath.row];
    
    //OVERRIDE SETTER THAT SETS LABELS TO NIB
    
    [cell.categoryView setCategoryForThisView:categoryForThisCell];

    return cell;
}





-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
    
    self.dataStore.currentCategorySearching = self.tourCategories[indexPath.row];
    [self performSegueWithIdentifier:@"showResultsSegue" sender:nil];
}


#pragma mark - UICollectionViewLayout

// Set size of collection cell
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(175, 175);
}

// set vertical seperation of cell
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    NSArray *ip = [self.categoryCollectionView indexPathsForSelectedItems];
    TRVGuideResultsTableViewController *destination = [segue destinationViewController];
    destination.selectedCity = self.selectedCity;
    
    if([segue.identifier isEqualToString:@"entrySegue"]) {
        
       /// pass over filters..
    }
}

@end
