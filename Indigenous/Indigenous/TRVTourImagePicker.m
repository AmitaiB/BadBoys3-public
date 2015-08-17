//
//  TRVTourImagePickerController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourImagePicker.h"

@interface TRVTourImagePicker ()

@property (strong, nonatomic) IBOutlet UIImageView *tourImageSelection;
@property (weak, nonatomic) IBOutlet UIButton *selectExistingPhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *takeNewPhotoButton;
- (IBAction)selectExistingPhotoButtonTapped:(id)sender;
- (IBAction)takeNewPhotoButtonTapped:(id)sender;

@end

@implementation TRVTourImagePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)takeNewPhotoButtonTapped:(UIButton*)sender {
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (IBAction)selectExistingPhotoButtonTapped:(id)sender {
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
