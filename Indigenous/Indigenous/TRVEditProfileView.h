//
//  TRVEditProfileView.h
//  
//
//  Created by Leo Kwan on 8/9/15.
//
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"

@interface TRVEditProfileView : UIView

@property (nonatomic, strong) TRVUser *userForThisEditProfileView;
@property (strong, nonatomic) IBOutlet UIView *contentView;


@end
