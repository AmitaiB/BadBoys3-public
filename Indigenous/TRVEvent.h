//
//  TRVEvent.h
//  Indigenous
//
//  Created by Leo Kwan on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRVEvent : NSObject

@property (nonatomic, strong) NSString *locationOfEvent;
@property (nonatomic)  NSInteger costOfEvent;
@property (nonatomic, strong) NSData *imageOfEvent;
@property (nonatomic, strong) NSString *addressOfEvent;
@property (nonatomic, strong) NSString *descriptionOfEvent;


@end
    