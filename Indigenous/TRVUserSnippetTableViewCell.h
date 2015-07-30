//
//  TRVUserSnippetTableViewCell.h
//  Indigenous
//
//  Created by Leo Kwan on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"
#import "TRVBio.h"

@interface TRVUserSnippetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTaglineLabel;
@property (nonatomic, strong) TRVUser *user;



@end
