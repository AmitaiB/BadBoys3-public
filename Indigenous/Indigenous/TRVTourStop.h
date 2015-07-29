//
//  TRVEvent.h
//  Indigenous
//
//  Created by Leo Kwan on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface TRVTourStop : NSObject

@property (nonatomic) CLLocationDegrees lat;
@property (nonatomic) CLLocationDegrees lng;
@property (nonatomic) CLLocationCoordinate2D *tourStopLocation;
@property (nonatomic, strong) GMSMarker *tourStopMarker;
@property (nonatomic) CGFloat operatorCost;
@property (nonatomic) CGFloat incidentalCost;

//@property (nonatomic) BOOL isDeparturePoint;
//@property (nonatomic) BOOL isFinalPoint;

    //@property (nonatomic, strong) NSString *locationOfEvent;
@property (nonatomic, strong) NSString *addressOfEvent;
@property (nonatomic) CGFloat costOfEvent;
@property (nonatomic, strong) NSString *descriptionOfEvent;
@property (nonatomic, strong) UIImage *image;


-(instancetype)initWithLocation:(NSString *)location address:(NSString *)address cost:(CGFloat)cost description:(NSString *)description;

@end
