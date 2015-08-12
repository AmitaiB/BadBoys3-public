//
//  TRVAddNewStopToItineraryVC.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVAddToursVC.h"
#import "TRVPickerMapViewController.h"
#import "TestMapWithSearchVC.h"
#import "TRVTour.h"
#import "TRVItinerary.h"
#import "TRVTourStop.h"
#import <Parse.h>
#import <MapKit/MapKit.h>
#import <RMSaveButton.h>
#import "TRVUserDataStore.h"
#import <CZPicker.h>

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVAddToursVC () <TRVPickerMapDelegate, MKMapViewDelegate>
@property (nonatomic, weak) IBOutlet RMSaveButton *saveTourButton;
@property (weak, nonatomic) IBOutlet UILabel *currentUserLabel;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (nonatomic, strong) TRVTourCategory *tourCategory;
@property (weak, nonatomic) IBOutlet UILabel *tourCategoryLabel;

- (IBAction)saveTourButton1:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *addTourNameTF;
- (IBAction)chooseCategoryButtonTapped:(id)sender;




@end

@implementation TRVAddToursVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    TRVBio *userBio = self.sharedDataStore.loggedInUser.userBio;
        //TODO: [Amitai]: Make attributed string?
    self.currentUserLabel.text = [NSString stringWithFormat:@"Hi, %@!", userBio.firstName];
    
    
    
    
    self.saveTourButton.startHandler      = ^void() {DBLG};
    self.saveTourButton.interruptHandler  = ^void() {DBLG};
    self.saveTourButton.completionHandler = ^void() {DBLG};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toMapSegueID"]) {
    TRVPickerMapViewController *destinationVC = segue.destinationViewController;
        destinationVC.delegate = self;
    } else if ([segue.identifier isEqualToString:@"toAppleMapSegueID"]) {
        TestMapWithSearchVC *destinationVC = segue.destinationViewController;
        destinationVC.delegate = self;
    }
    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

//- (void)initializeNewTourConstruct {
//    PFObject *itineraryUnderConstruction = [PFObject objectWithClassName:@"TourUnderConstruction"];
//        //TODO:[Amitai] store the growing itinerary in a PFObject to the local datastore
//}

/**
 *  Make sure that a PFObject[@"TourUnderConstruction"][@"ItineraryUnderConstruction"] exists, and save it to @"AddTourPins"...
 */
- (void)userSelectedTourStopLocation:(CLLocation*)location
{
    DBLG
    BOOL didBadBoys3SolveThePFObjectBug = YES;
    if (didBadBoys3SolveThePFObjectBug) {
    
        PFQuery *tourQuery = [PFQuery queryWithClassName:@"ItineraryUnderConstruction"];
                            [tourQuery whereKeyExists:@"Itinerary"];
                            [tourQuery fromPinWithName:@"AddTourVC_Pins"];
        TRVItinerary * itineraryUnderConstruction_TRV;
        PFObject     * itineraryUnderConstruction_PF;
        NSError *queryError = nil;
        NSArray *itineraryObjects = [tourQuery findObjects:&queryError];
        NSLog(@"NSArray <PFObjects> itineraryObjects: %@", [itineraryObjects description]);
        if (queryError) { //If PFObjectWithClassName: @"ItineraryUnderConstruction" does not exist...
                //...then set our itinerary pointers to new objects....
            itineraryUnderConstruction_PF = [PFObject objectWithClassName:@"ItineraryUnderConstruction"];
            itineraryUnderConstruction_TRV = [TRVItinerary new];
            [itineraryUnderConstruction_PF addObject:itineraryUnderConstruction_TRV forKey:@"Itinerary"];
        } else {
                //...if an itinerary object(s) already exist, then our pointers should let us build on them.
            itineraryUnderConstruction_PF = [tourQuery getFirstObject];
            itineraryUnderConstruction_TRV = (TRVItinerary*)itineraryUnderConstruction_PF[@"Itinerary"];
        }
            //Either way, we now have a/our TRVItinerary...
        TRVTourStop *newStop = [[TRVTourStop alloc] initWithCoordinates:location.coordinate];
        [itineraryUnderConstruction_TRV.tourStops addObject:newStop];
        itineraryUnderConstruction_PF[@"Itinerary"] = itineraryUnderConstruction_TRV;
        NSLog(@"The itinerary under construction now has %lu tour stops", itineraryUnderConstruction_TRV.tourStops.count);
        [itineraryUnderConstruction_PF pinWithName:@"AddTourVC_Pins"];
    } else {
        DBLG
        NSLog(@"Need to solve the bug (Invalid write to JSON(TVRItinerary))\nOh, and CLLocation is %@:", [location description]);
    }
}

    //!!!
- (IBAction)saveTourButton1:(id)sender {
        //Save Tour as TRVTourObject to Parse:TRVUser
}

- (IBAction)chooseCategoryButtonTapped:(id)sender {
    CZPickerView *categoryPicker = [[CZPickerView alloc] initWithHeaderTitle:@"Tour Category"
                                                           cancelButtonTitle:@"Still Can't Decide"
                                                          confirmButtonTitle:@"Yup, that's it!"];
    categoryPicker.delegate = self;
    categoryPicker.dataSource = self;
    categoryPicker.needFooterView = YES;
    [categoryPicker show];
}

#pragma mark - CZPickerViewDataSource

-(NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView {
    return 4;
}

-(NSAttributedString *)czpickerView:(CZPickerView *)pickerView attributedTitleForRow:(NSInteger)row {
    NSArray *categoryTitles = @[@"See", @"Play", @"Eat", @"Drink"];
    return categoryTitles[row];
}

#pragma mark - CZPickerViewDelegate

-(void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row {
    DBLG

    /**
     *  FIXME: Get Tim/Joe's help on the syntax...
     */
    NSArray *categoryTitles = @[@"See", @"Play", @"Eat", @"Drink"];
    NSString *chosenCategory = categoryTitles[row];
//
//    NSMethodSignature *categoryInitSignature = [TRVTourCategory instanceMethodSignatureForSelector:@selector(initWithName:)];
//    NSInvocation *createChosenCategoryObject = [NSInvocation invocationWithMethodSignature:categoryInitSignature];
//    createChosenCategoryObject.target = self.tourCategory;
//    createChosenCategoryObject.selector = @selector(initWithName:);
//    [createChosenCategoryObject setArgument:&chosenCategory atIndex:2];
//    NSUInteger length = [[createChosenCategoryObject methodSignature] methodReturnLength];
////    buffer = (void *)malloc(length);
//    
//    [createChosenCategoryObject invoke];
////    createChosenCategoryObject getReturnValue:<#(void *)#>
//    self.tourCategory = //whatever the returnObject is.
    self.tourCategory = [[TRVTourCategory alloc] initWithName:categoryTitles[row]];
    self.tourCategoryLabel.text = self.tourCategory.categoryName;
}

-(void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView {
    [pickerView resignFirstResponder];
}


@end
