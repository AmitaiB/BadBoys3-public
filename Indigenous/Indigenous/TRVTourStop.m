//
//  TRVEvent.m
//  Indigenous
//
//  Created by Leo Kwan on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStop.h"

@implementation TRVTourStop


-initWithCoordinates:(CLLocationCoordinate2D)coordinates
        operatorCost:(CGFloat)oCost
      incidentalCost:(CGFloat)iCost {
    
    if (!self) {
        return nil;
    }
    _operatorCost     = oCost;
    _incidentalCost   = iCost;
    _tourStopLocation = coordinates;
    _lat              = coordinates.latitude;
    _lng              = coordinates.longitude;
    _tourStopMarker   = [GMSMarker markerWithPosition:coordinates];
    
    return self;
};

-(id)initWithCoordinates:(CLLocationCoordinate2D)coordinates {
    return [self initWithCoordinates:coordinates
                        operatorCost:0
                      incidentalCost:0];
}

-(id)initWithMapMarker:(GMSMarker *)marker {
    _tourStopMarker = marker;
    return [self initWithCoordinates:marker.position];
}


@end
