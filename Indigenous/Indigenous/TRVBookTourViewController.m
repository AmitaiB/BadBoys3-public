//
//  TRVBookTourViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/11/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVBookTourViewController.h"
#import "TRVUser.h"

@interface TRVBookTourViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameOfTourLabel;
@property (nonatomic, strong) TRVUser *guideForThisTour;
    
@end

@implementation TRVBookTourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameOfTourLabel.text = self.destinationTour.itineraryForThisTour.nameOfTour;
    // Do any additional setup after loading the view.
}
- (IBAction)goBackButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"BYE");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
