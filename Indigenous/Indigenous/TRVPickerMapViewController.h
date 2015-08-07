//
//  TRVPickerMapViewController.h
//  Indigenous
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLLocation;

@protocol TRVPickerMapDelegate <NSObject>

-(void)userSelectedTourStopLocation:(CLLocation*)location;

@end


@interface TRVPickerMapViewController : UIViewController

@property (nonatomic, strong) id<TRVPickerMapDelegate> delegate;

@end
