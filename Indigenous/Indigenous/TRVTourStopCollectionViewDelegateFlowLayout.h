//
//  TRVTourStopCollectionViewDelegateFlowLayout.h
//  Indigenous
//
//  Created by Daniel Wickes on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TRVTouristTripDetailViewController.h"

@interface TRVTourStopCollectionViewDelegateFlowLayout : NSObject <UICollectionViewDelegateFlowLayout, TRVTouristTripDetailViewControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end
