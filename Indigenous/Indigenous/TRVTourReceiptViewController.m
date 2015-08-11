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
    [self dismissViewControllerAnimated:NO completion:^{
        
        [presentingViewController dismissViewControllerAnimated:NO completion:^{
            
//            
//            UIStoryboard *destinationStoryboard = [UIStoryboard storyboardWithName:@"TRVTabBar" bundle:nil];;
//            
//                UIViewController *destination = [destinationStoryboard instantiateInitialViewController];
//            [self presentViewController:destination animated:YES completion:nil];
        }];
         }];
    
}


@end
