//
//  TRVNetworkRechabilityMonitor.h
//  Indigenous
//
//  Created by Leo Kwan on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRVNetworkRechabilityMonitor : NSObject

+(void)startNetworkReachabilityMonitoring;
+(BOOL)checkNetworkStatus;


@end
