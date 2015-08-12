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
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *languagesTextField;


@property (weak, nonatomic) IBOutlet UITableViewCell *taglineCell;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *aboutMeCell;
@property (weak, nonatomic) IBOutlet UILabel *aboutMeLabel;
@property (weak, nonatomic) IBOutlet UITextField *homeCityLabel;
@property (weak, nonatomic) IBOutlet UITextField *homeCountryLabel;


@end

@implementation TRVEditProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed)];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    
    
    
    // set labels
    self.firstNameTextField.text = self.sharedDataStore.loggedInUser.userBio.firstName;
    self.lastNameTextField.text = self.sharedDataStore.loggedInUser.userBio.lastName;
    self.emailTextField.text = self.sharedDataStore.loggedInUser.userBio.email;
    self.languagesTextField.text = self.sharedDataStore.loggedInUser.userBio.language;
 }

-(void)viewWillAppear:(BOOL)animated {

    [self.tableView reloadData];
}
    
    
-(void)saveButtonPressed {
    NSLog(@"SAVED");
    
    PFUser *currentUser = [PFUser currentUser];
    
    PFObject *userBio = currentUser[@"userBio"];
    
    
    userBio[@"email"] = self.emailTextField.text;
    currentUser[@"email"] = self.emailTextField.text;
    userBio[@"languagesSpoken"] = self.languagesTextField.text;
    
    //save locally
    self.sharedDataStore.loggedInUser.userBio.email = self.emailTextField.text;
    self.sharedDataStore.loggedInUser.userBio.language = self.languagesTextField.text;
    self.sharedDataStore.loggedInUser.userBio.firstName = self.firstNameTextField.text;
    self.sharedDataStore.loggedInUser.userBio.lastName = self.lastNameTextField.text;

    
    // save on parse
    [currentUser saveEventually];
    
    
    
    // save things to parse
    [self.navigationController popViewControllerAnimated:YES];
}
    
    
    
    
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
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



@end
