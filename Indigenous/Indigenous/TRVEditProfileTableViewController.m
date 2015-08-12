//
//  TRVEditProfileTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVEditProfileTableViewController.h"
#import "TRVEditTextViewController.h"
#import "TRVUserDataStore.h"
#import <Masonry.h>

@interface TRVEditProfileTableViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *aboutMeContentView;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (weak, nonatomic) IBOutlet UITableViewCell *testCell;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
- (IBAction)taglineEditButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITableViewCell *taglineCell;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *aboutMeCell;
@property (weak, nonatomic) IBOutlet UILabel *aboutMeLabel;


@end

@implementation TRVEditProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
//    [self.taglineLabel sizeToFit];
    self.firstNameTextField.text = self.sharedDataStore.loggedInUser.userBio.firstName;
    NSLog(@"%@", self.sharedDataStore.loggedInUser.userBio.firstName);
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    UITableViewCell *theCellClicked = [tableView cellForRowAtIndexPath:indexPath];
   
    if (theCellClicked == self.taglineCell) {

        [self presentEditViewControllerWithText:self.taglineLabel.text];
        
    } else if (theCellClicked == self.aboutMeCell) {
        NSLog(@"are you in here?");
        [self presentEditViewControllerWithText:self.aboutMeLabel.text];
        
    }

    
}

-(void)presentEditViewControllerWithText:(NSString *)text {
    NSLog(@"are you in this segue...");

    UIStoryboard *editText = [UIStoryboard storyboardWithName:@"TRVEditText" bundle:nil];
    
    TRVEditTextViewController *destination = [editText instantiateInitialViewController];
    
    destination.destinationTextToEdit = text;

    
    [self presentViewController:destination animated:YES completion:nil];
    
}

- (IBAction)taglineEditButtonPressed:(id)sender {
    
    
}


@end
