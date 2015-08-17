//
//  TRVConfirmTourViewController.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVTourObject.h"

@interface TRVConfirmTourViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *tourImage;
@property (weak, nonatomic) IBOutlet UILabel *tourName;
@property (weak, nonatomic) IBOutlet UILabel *tourCategory;
@property (weak, nonatomic) IBOutlet UILabel *tourArea;
@property (weak, nonatomic) IBOutlet UITableView *itineraryTableView;

@property (strong, nonatomic) TRVTourObject *tourObject;

@end
