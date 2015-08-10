//
//  TRVUser.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUser.h"

@implementation TRVUser

-(instancetype)initWithBio:(TRVBio *)bio {
    
    self = [super init];
    
    if (self) {
        _userBio = bio;
    }
    return self;
}

//@property (nonatomic, strong) NSString *parseObjectID; //Is this a string?
//@property (nonatomic, strong) TRVBio *userBio;
//@property (nonatomic) TRVRating *rating;
//@property (nonatomic, strong) NSMutableArray *myTrips;
//@property (nonatomic, strong) NSMutableArray *allTrips;  //past trips are tripHistory, futureTrips are, say, myUpcomingTrips.
//@property (nonatomic, strong) NSMutableArray *tourCatalog;  //In the industry, a tour catalog is a publication by tour wholesalers listing their tour offerings. Catalogs are distributed to retail agents who make them available to their customers, and book them (for commissions). For our purposes, this is a listing of the Tours 'owned' by this user.
////@property (nonatomic, strong) NSMutableArray *tripsLeading;
////@property (nonatomic, strong) NSMutableArray *tripsTaking;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.parseObjectID = [decoder decodeObjectForKey:@"parseObjectID"];
        self.userBio = [decoder decodeObjectOfClass:[TRVBio class] forKey:@"userBio"];
        self.myTrips = [decoder decodeObjectOfClass:[NSMutableArray class] forKey:@"myTrips"];
        self.allTrips = [decoder decodeObjectOfClass:[NSMutableArray class] forKey:@"allTrips"];
        self.tourCatalog = [decoder decodeObjectOfClass:[NSMutableArray class] forKey:@"tourCatalog"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.parseObjectID forKey:@"parseObjectID"];
    [encoder encodeObject:self.userBio forKey:@"userBio"];
    [encoder encodeObject:self.myTrips forKey:@"myTrips"];
    [encoder encodeObject:self.allTrips forKey:@"allTrips"];
    [encoder encodeObject:self.tourCatalog forKey:@"tourCatalog"];

    
    
}


@end
