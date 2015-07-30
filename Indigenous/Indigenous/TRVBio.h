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

// Don't need a username really.  We go via Fist and Last name.
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic) NSUInteger phoneNumber;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, strong) NSString *bioDescription;

// Not sure if we need interests
@property (nonatomic, strong) NSMutableArray *interests;
@property (nonatomic, strong) NSString *language;


//GUIDE SPECIFIC PROPERTIES
@property (nonatomic) NSUInteger age;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *oneLineSummary;


//INITIALIZERS
-(instancetype)initTourist;
-(instancetype)initGuide;

-(instancetype)initTouristWithUserName:(NSString*)username
                      firstName:(NSString*)firstName
                       lastName:(NSString*)lastName
                          email:(NSString*)email
                    phoneNumber:(NSUInteger)phoneNumber
                   profileImage:(UIImage*)profileImage
                 bioDescription:(NSString*)bioDescription
                      interests:(NSMutableArray*)interests
                       language:(NSString*)language;

-(instancetype)initGuideWithUserName:(NSString*)username
                             firstName:(NSString*)firstName
                              lastName:(NSString*)lastName
                                 email:(NSString*)email
                           phoneNumber:(NSUInteger)phoneNumber
                          profileImage:(UIImage*)profileImage
                        bioDescription:(NSString*)bioDescription
                             interests:(NSMutableArray*)interests
                              language:(NSString*)language
                                 age:(NSUInteger)age
                              gender:(NSString*)gender
                              region:(NSString*)region
                      oneLineSummary:(NSString*)oneLineSummary;

-(void)convertTouristToGuideWithAge:(NSUInteger)age
                             gender:(NSString*)gender
                             region:(NSString*)region
                     oneLineSummary:(NSString*)oneLineSummary;



@end
