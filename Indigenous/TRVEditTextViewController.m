//
//  TRVEditTextViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/12/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVEditTextViewController.h"

@interface TRVEditTextViewController ()<UITextViewDelegate>

@end

@implementation TRVEditTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.editTextView.text = self.destinationTextToEdit;
    
}


- (IBAction)savebuttonPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
            NSLog(@"being dismissed");
             [self.delegate returnEditedText:self.editTextView.text];
            NSLog(@" IN The done button pressed %@", self.editTextView.text);
        }];
}


@end
