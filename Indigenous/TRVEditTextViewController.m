//
//  TRVEditTextViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/12/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVEditTextViewController.h"

@interface TRVEditTextViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *editTextView;

@end

@implementation TRVEditTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.editTextView.text = self.destinationTextToEdit;
}


- (IBAction)saveButtonPressed:(id)sender {
    [self.delegate returnEditedText:self.editTextView.text];
}


- (void)textViewDidEndEditing:(UITextView *)textView {

}



@end
