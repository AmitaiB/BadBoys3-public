//
//  TRVTourView.h
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVTour.h"

@interface TRVTourView : UIView

@property (nonatomic, strong) TRVTour *tourForThisTourView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *tourImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfTourLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStopsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tourRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *upcomingDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIconImageView;



@end
