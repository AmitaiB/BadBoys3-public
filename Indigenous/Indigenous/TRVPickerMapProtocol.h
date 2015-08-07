//
//  TRVPickerMapProtocol.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/7/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol TRVPickerMapDelegate <NSObject>
@required
- (void)userSelectedTourStopLocation:(CLLocation*)location;
@end

@interface TRVPickerMapProtocol : NSObject

{
    id <TRVPickerMapDelegate> _delegate;
}

@property (nonatomic, strong) id delegate;

- (void)userConfirmedLocationSelection;

@end
