//
//  TRVBuildItineraryViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVConfirmTourViewController.h"
#import "TRVBuildItineraryViewController.h"
#import <HNKGooglePlacesAutocomplete.h>
#import "TRVConstants.h"
#import <FlatUIKit.h>
#import <CLPlacemark+HNKAdditions.h>
#import <NSString+Icons.h>

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVBuildItineraryViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (weak, nonatomic) IBOutlet UITableView *autocompleteTableView;

@property (weak, nonatomic) IBOutlet FUIButton *currentTourStopSelectionButton;
@property (strong, nonatomic) NSMutableArray *currentItinerary;
@property (weak, nonatomic) IBOutlet FUIButton *panoramaAndCaptureButton;
- (IBAction)panoramaAndCaptureButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *panoramaView;
- (IBAction)currentTourStopSelectionButtonTapped:(id)sender;

@property (strong, nonatomic) CLPlacemark *currentPlacemark;

//@property (weak, nonatomic) IBOutlet UITableView *itineraryTableView;
@end

@implementation TRVBuildItineraryViewController {
    GMSPanoramaView *panoView_;
}

static NSString * const searchCellReuseID = @"searchCellReuseID";
static NSString * const itineraryCellReuseID = @"itineraryCellReuseID";

-(void)loadView {
    [super loadView];
    
    panoView_ = [[GMSPanoramaView alloc] initWithFrame:CGRectZero];
    self.panoramaView = panoView_;
    panoView_.delegate = self;
    panoView_.navigationLinksHidden = YES;
    panoView_.layer.zPosition = 0.5;
    panoView_.backgroundColor = [UIColor cloudsColor];
    [panoView_ setAllGesturesEnabled:NO];
    panoView_.orientationGestures = YES;
    panoView_.panorama = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];;
    
    // Do any additional setup after loading the view.
    
    self.searchResults                         = [NSMutableArray new];
    self.currentItinerary                      = [NSMutableArray new];

    self.searchBar.delegate                    = self;
//    self.itineraryTableView.delegate           = self;
//    self.itineraryTableView.dataSource         = self;
    self.autocompleteTableView.delegate        = self;
    self.autocompleteTableView.dataSource      = self;

        //Set up a pretty button...
    [self initializeButton:self.panoramaAndCaptureButton withThemeColor:[UIColor turquoiseColor] andColor:[UIColor greenSeaColor]];
    self.panoramaAndCaptureButton.titleLabel.font = [UIFont iconFontWithSize:18];
    self.panoramaAndCaptureButton.titleLabel.text = [NSString iconStringForEnum:FUIImage];
    self.panoramaAndCaptureButton.layer.zPosition = 1.0;
    self.panoramaAndCaptureButton.hidden = YES;
    
        //...or two...
    [self initializeButton:self.currentTourStopSelectionButton withThemeColor:[UIColor peterRiverColor] andColor:[UIColor belizeHoleColor]];
    
//    self.autocompleteTableView.backgroundColor = [UIColor greenSeaColor];
//    self.itineraryTableView.backgroundColor    = [UIColor wisteriaColor];
    
}

-(void)initializeButton:(FUIButton*)button withThemeColor:(UIColor*)color1 andColor:(UIColor*)color2 {
    button.buttonColor = color1;
    button.shadowColor = color2;
    button.shadowHeight = 3.0f;
    button.cornerRadius = 6.0f;
    button.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate methods

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    DBLG
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text = @"";
    [self.searchResults removeAllObjects];
    [self.autocompleteTableView reloadData];
    [searchBar resignFirstResponder];
DBLG
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    DBLG
    HNKGooglePlacesAutocompleteQuery *googleQueryHNK = [HNKGooglePlacesAutocompleteQuery sharedQuery];
    
    self.autocompleteTableView.hidden = NO;
    
    [googleQueryHNK fetchPlacesForSearchQuery:searchText completion:^(NSArray *places, NSError *error) {
        if (error) {
            NSLog(@"ERROR! %@", error.localizedDescription);
        } else {
            self.searchResults = [places mutableCopy];
            [self.autocompleteTableView reloadData];
        }
    }];
}

/**
 *  unnecessary, but who knows...?
 */
-(void)configureHNKQuery {
    HNKGooglePlacesAutocompleteQueryConfig *config = [HNKGooglePlacesAutocompleteQueryConfig new];
    config.country = @"us";
    config.language = @"en";
    config.filter = HNKGooglePlaceTypeAutocompleteFilterAddress;
}



#pragma mark -TableviewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.autocompleteTableView]) {
        return self.searchResults.count;
    }
//    if ([tableView isEqual:self.itineraryTableView]) {
//        return self.currentItinerary.count;
//    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if ([tableView isEqual:self.autocompleteTableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:searchCellReuseID forIndexPath:indexPath];
        HNKGooglePlacesAutocompletePlace *daPlace = (HNKGooglePlacesAutocompletePlace*)self.searchResults[indexPath.row];
        cell.textLabel.text = daPlace.name;
    }
    
//    if ([tableView isEqual:self.itineraryTableView]) {
//        cell = [tableView dequeueReusableCellWithIdentifier:itineraryCellReuseID forIndexPath:indexPath];
//        HNKGooglePlacesAutocompletePlace *daPlace = (HNKGooglePlacesAutocompletePlace*)self.currentItinerary[indexPath.row];
//        cell.textLabel.text = daPlace.name;
    }
    return cell;
}

#pragma mark - TableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.autocompleteTableView]) {
        [self.currentItinerary addObject:self.searchResults[indexPath.row]];
[CLPlacemark hnk_placemarkFromGooglePlace:                                  (HNKGooglePlacesAutocompletePlace*)self.searchResults[indexPath.row]
 apiKey:GOOGLE_API_KEY2 completion:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
     self.currentTourStopSelectionButton.titleLabel.text = addressString;
     self.currentPlacemark = placemark;
 }];
//        [self.itineraryTableView reloadData];
        [self.searchBar.delegate searchBarCancelButtonClicked:self.searchBar]; //Because you want the same functionality to happen.
    }
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     self.tourObject.tourItinerary = self.currentItinerary;
     TRVConfirmTourViewController *destinationVC = segue.destinationViewController;
     destinationVC.tourObject = self.tourObject;
     
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

    //first see if this works...
- (IBAction)panoramaAndCaptureButtonTapped:(id)sender {
    UIGraphicsBeginImageContext(panoView_.frame.size);
    self.tourObject.tourImage = UIGraphicsGetImageFromCurrentImageContext();
}


- (IBAction)currentTourStopSelectionButtonTapped:(id)sender {
    [panoView_ moveNearCoordinate:self.currentPlacemark.location.coordinate radius:30];
    self.panoramaAndCaptureButton.hidden = NO;
}
@end
