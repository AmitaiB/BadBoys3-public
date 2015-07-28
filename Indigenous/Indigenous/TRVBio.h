//
//  TRVBio.h
//  Indigenous
//
//  Created by Alan Scarpa on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRVBio : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic) NSUInteger phoneNumber;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, strong) NSString *bioDescription;
@property (nonatomic, strong) NSMutableArray *interests;
@property (nonatomic, strong) NSString *language;


//GUIDE SPECIFIC PROPERTIES
@property (nonatomic) NSUInteger age;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *region;


@end
