//
//  TRVTourStopCollectionViewDelegateFlowLayout.m
//  Indigenous
//
//  Created by Daniel Wickes on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStopCollectionViewDelegateFlowLayout.h"
#import "TRVTourStopCollectionViewCell.h"

@implementation TRVTourStopCollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.bounds.size.width / 10;
    return CGSizeMake(width, collectionView.bounds.size.height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TRVTourStopCollectionViewCell *cell = (TRVTourStopCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell selectionAnimation];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    UICollectionView *cv = (UICollectionView*)scrollView;
    //UIView *cell = [cv cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    *targetContentOffset = scrollView.contentOffset; // set acceleration to 0.0
    int minSpace = 10;
    //
    int numberOfCells = 15;
    int totalBlankSpace = numberOfCells * minSpace;
    int pageWidth = (scrollView.frame.size.width - totalBlankSpace) / numberOfCells;
    
    //NSLayoutConstraint *constraint = cv.constraints[0];
    //constraint.constant = pageWidth + 20;
    //
//    float pageWidth = 50;//(float)scrollView.bounds.size.width;

    
    int cellToSwipe = (scrollView.contentOffset.x)/(pageWidth + minSpace) + 0.5; // cell width + min spacing for lines
    if (cellToSwipe < 0) {
        cellToSwipe = 0;
    } else if (cellToSwipe >= 50) {
        cellToSwipe = 50 - 1;
    }
    
    [cv scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellToSwipe inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

@end
