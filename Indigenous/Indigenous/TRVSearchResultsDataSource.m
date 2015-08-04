////
////  TRVSearchResultsDataSource.m
////  Indigenous
////
////  Created by Leo Kwan on 8/2/15.
////  Copyright (c) 2015 Bad Boys 3. All rights reserved.
////
//
//#import "TRVSearchResultsDataSource.h"
//#import "TRVGuideProfileTableViewCell.h"
//
//@interface TRVSearchResultsDataSource ()<UIGestureRecognizerDelegate>
//
//@property (nonatomic, strong) TRVGuideProfileTableViewCell *cell;
//
//@end
//
//@implementation TRVSearchResultsDataSource
////
////- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
////    return 1;
////}
////
////- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
////    
////    self.user = [[TRVUser alloc] init];
////    
////    
////    self.user.userBio = [[TRVBio alloc] initTouristWithUserName:@"Ashley" firstName:@"Ashley" lastName:@"Madison" email:@"ashleyfromthe6@gmail.com" phoneNumber:7188866958 profileImage:[UIImage imageNamed:@"leo.jpg"] bioDescription:@"great person" interests:[NSMutableArray arrayWithObjects:@"hi", @"hi", nil] language:@"English"];
////    self.user.userBio.homeCity = @"New York";
////    self.user.userBio.homeCountry = @"United States";
////    self.user.userBio.userTagline = @"Loves fried chicken and ramen. Super Spontaneous Person!";
////    self.user.userBio.profileImage = [UIImage imageNamed:@"leo.jpg"];
////
////    
////    TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
////        cell.guideForThisCell = self.user;
////    
////    
////    return cell;
////    
////}
////
////-(void)addTapToProfileImageView {
////    
////    [self.cell.profileImageViewNib setUserInteractionEnabled:YES];
////    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
////    [self.cell.profileImageViewNib addGestureRecognizer:singleTap];
////    singleTap.delegate = self;
////}
////
////- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
////    
////    [self.
////}
////     
////     
////- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//// self.nav
////}
////
////
//
//
//@end
