//
//  TRVAddTourDataViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <SCLAlertView.h>
#import "TRVBuildItineraryViewController.h"
#import "TRVTourImagePicker.h"
#import "TRVAddTourDataViewController.h"
#import "TRVTourObject.h"
#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVAddTourDataViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tourNameTxF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tourCategorySegControl;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@property (strong, nonatomic) TRVTourObject *tourObject;
- (IBAction)dateButtonTapped:(id)sender;
- (IBAction)imageButtonTapped:(id)sender;

@end

@implementation TRVAddTourDataViewController

static NSString * const addTourToBuildItinerarySegueID = @"addTourToBuildItinerarySegueID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tourObject = [TRVTourObject new];
    [self initializeSegmentedControl];
    [self initializeDatePicker];
    // Do any additional setup after loading the view.
    

}

#pragma mark - ImageView and ImagePicker methods




#pragma mark - Date (UIButton) and UIDatePicker methods

- (IBAction)dateButtonTapped:(id)sender {
    DBLG
    NSLog(@"DateButton doesn't do anything yet");
}

- (IBAction)imageButtonTapped:(id)sender {
    UIAlertController *photoActionAlert = [UIAlertController alertControllerWithTitle:@"Choose Photo Source" message:@"Would you prefer to Select an Existing Photo from your device, or Take a New Photo?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"Take New Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self takeNewPhoto];
        DBLG
    }];
    
    UIAlertAction *selectPhotoAction = [UIAlertAction actionWithTitle:@"Select Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectExistingPhoto];
        DBLG
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        DBLG
    }];
    [photoActionAlert addAction:takePhotoAction];
    [photoActionAlert addAction:selectPhotoAction];
    [photoActionAlert addAction:cancelAction];
    
    [self presentViewController:photoActionAlert animated:YES completion:^{
        DBLG
    }];
}
/**
 *  TODO: Check if device has camera.
 */
- (void)takeNewPhoto {
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePicker animated:YES completion:^{
        DBLG
    }];
}

- (void)selectExistingPhoto {
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:^{
        DBLG
    }];
}

#pragma mark - UIImagePickerControllerDelegate methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self.imageButton setImage:info[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self presentViewController:picker animated:YES completion:^{
        DBLG
    }];
}



-(void)initializeDatePicker {
    [self.datePicker addTarget:self action:@selector(assignTourDate) forControlEvents:UIControlEventValueChanged];
}

-(void)assignTourDate {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    self.dateButton.titleLabel.text = [dateFormatter stringFromDate:self.tourObject.tourDate];
    NSLog(@"Tour Date set to: %@", [dateFormatter stringFromDate:self.tourObject.tourDate]);
}


#pragma mark - UISegmentedControl methods

-(void)initializeSegmentedControl {
    [self.tourCategorySegControl setSelectedSegmentIndex:-1];
    [self.tourCategorySegControl addTarget:self action:@selector(assignTourCategory) forControlEvents:UIControlEventValueChanged];
}

-(void)assignTourCategory {
    NSString *categoryChosenViaSegmentedControl = self.tourObject.tourCategories[self.tourCategorySegControl.selectedSegmentIndex];
    NSLog(@"TourCategory set to: %@", self.tourObject.tourCategory);
    NSLog(@"%@", [self.tourCategorySegControl titleForSegmentAtIndex:self.tourCategorySegControl.selectedSegmentIndex]);
}

#pragma mark - UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"TourName set to: %@", self.tourObject.tourName);
    return YES;
}


#pragma mark - Navigation
    //Current debug guess: initWithWindow goes with one kind of method.
    //initWithWindow
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (self.tourCategorySegControl.selectedSegmentIndex == -1) {
        SCLAlertView *noCategoryAlert = [[SCLAlertView alloc] initWithNewWindow];
        [noCategoryAlert showError:@"No Category Selected" subTitle:@"Please select a category for your tour offering." closeButtonTitle:@"Close" duration:0.0f];
        return NO;
    } else return YES;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%@\n%lu\n%@", self.tourNameTxF.text, self.tourCategorySegControl.selectedSegmentIndex, self.datePicker.self);
    
    /**
     *  Uses segue to pass forward Tour information.
     */
    self.tourObject.tourDate = self.datePicker.date;
    self.tourObject.tourName = self.tourNameTxF.text;
    self.tourObject.tourCategory = [self.tourCategorySegControl titleForSegmentAtIndex:self.tourCategorySegControl.selectedSegmentIndex];
    self.tourObject.tourImage =  self.imageButton.imageView.image;
    
    TRVBuildItineraryViewController *destinationVC = segue.destinationViewController;
    destinationVC.tourObject = self.tourObject;
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
