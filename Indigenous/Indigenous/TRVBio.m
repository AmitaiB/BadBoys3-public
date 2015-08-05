//
//  TRVBio.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVBio.h"

@implementation TRVBio


-(instancetype)initTouristWithUserName:(NSString*)username
                             firstName:(NSString*)firstName
                              lastName:(NSString*)lastName
                                 email:(NSString*)email
                           phoneNumber:(NSUInteger)phoneNumber
                          profileImage:(UIImage*)profileImage
                        bioDescription:(NSString*)bioDescription
                             interests:(NSMutableArray*)interests
                              language:(NSString*)language
{
    self = [super init];
    if (self){
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _phoneNumber = phoneNumber;
        _profileImage = profileImage;
        _bioDescription = bioDescription;
        _interests = interests;
        _language = language;
    }
    return self;
}

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
{
    
    self = [super init];
    if (self){
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _phoneNumber = phoneNumber;
        _profileImage = profileImage;
        _bioDescription = bioDescription;
        _interests = interests;
        _language = language;
        _age = age;
        _gender = gender;
        _region = region;
    }
    return self;
    
    
}



@end
