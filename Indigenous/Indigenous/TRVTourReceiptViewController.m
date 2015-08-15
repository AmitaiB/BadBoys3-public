//
//  TRVTourReceiptViewController.m
//  
//
//  Created by Leo Kwan on 8/11/15.
//
//

#import "TRVTourReceiptViewController.h"

@interface TRVTourReceiptViewController ()

@end

@implementation TRVTourReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backToHomeButtonPressed:(id)sender {
    
    

    
    UIViewController *presentingViewController = self.presentingViewController;
    
    // SET THE TRANSITION BACK ON BACK HOME
    presentingViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [presentingViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
}


@end
