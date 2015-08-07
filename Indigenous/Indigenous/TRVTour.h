//
//  TRVTour.h
//  Indigenous


#import <UIKit/UIKit.h>
#import "TRVItinerary.h"
#import "TRVUser.h"
#import "TRVItinerary.h"

@interface TRVTour : NSObject

//The user that created/owns this Tour object.
@property (nonatomic, strong, nonnull) TRVUser *guideForThisTour;
@property (nonatomic, strong, nonnull) TRVItinerary *itineraryForThisTour;
@property (nonatomic, strong, nonnull) NSDate *tourDeparture;        //The date of the start of a tour program.
@property (nonatomic, nonnull) CGFloat *tourAverageRating;

-(instancetype)initWithGuideUser:(TRVUser *)guideUser itineraryForThisTour:(TRVItinerary *)itinerary;

@end
