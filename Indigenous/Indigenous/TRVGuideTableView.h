//
//  TRVGuideTableView.h
//  Indigenous
//
//  Created by Leo Kwan on 8/7/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRVGuideTableView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end
