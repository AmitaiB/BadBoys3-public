//
//  TRVEditTourDataViewController.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/16/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CZPicker.h>

@interface TRVEditTourDataViewController : UIViewController <CZPickerViewDelegate, CZPickerViewDataSource>

@property (strong, nonatomic) NSArray *tourCategories;

@end
