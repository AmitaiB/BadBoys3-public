//
//  TRVTourStopCollectionViewDataSource.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStopCollectionViewDataSource.h"
#import "TRVTourStop.h"

@implementation TRVTourStopCollectionViewDataSource {
    NSArray *_stops;
    void (^_configureCell)(TRVTourStop*);
}

-(instancetype)initWithStops:(NSArray*)stops configuration:(void (^)(TRVTourStop*))configureCell {
    if (self = [super init]) {
        _stops = stops;
        _configureCell = configureCell;
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
