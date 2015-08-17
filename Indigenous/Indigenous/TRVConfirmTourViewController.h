//
//  TRVConfirmTourViewController.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVTourObject.h"

@interface TRVConfirmTourViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *tourImageView;
@property (weak, nonatomic) IBOutlet UILabel *tourNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tourCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tourAreaLabel;
@property (weak, nonatomic) IBOutlet UITableView *finalItineraryTableView;

@property (strong, nonatomic) TRVTourObject *tourObject;
@property (nonatomic) BOOL isGeocoded;

@end
