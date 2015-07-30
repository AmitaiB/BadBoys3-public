//
//  ProfileImageTableViewCell.h
//  Pods
//
//  Created by Leo Kwan on 7/30/15.
//
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"
#import "TRVBio.h"

@interface TRVProfileImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (nonatomic, strong) TRVUser *userForThisImageCell;

@end
