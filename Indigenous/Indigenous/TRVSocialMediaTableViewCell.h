//
//  TRVSocialMediaTableViewCell.h
//  Indigenous
//
//  Created by Leo Kwan on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "TRVUser.h"
#import "TRVBio.h"
@interface TRVSocialMediaTableViewCell : UITableViewCell

@property (nonatomic, strong) TRVUser *userForThisConnectCell;

@end
