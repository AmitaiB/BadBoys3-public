//
//  TRVBuildItineraryViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVBuildItineraryViewController.h"
#import <HNKGooglePlacesAutocomplete.h>
#import "TRVConstants.h"
#import <FlatUIKit.h>

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVBuildItineraryViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *autocompleteTableView;
@property (weak, nonatomic) IBOutlet UITableView *itineraryTableView;
@property (weak, nonatomic) IBOutlet UILabel *someLabel;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableArray *currentItinerary;


@end

@implementation TRVBuildItineraryViewController

static NSString * const searchCellReuseID = @"searchCellReuseID";
static NSString * const itineraryCellReuseID = @"itineraryCellReuseID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchResults                         = [NSMutableArray new];
    self.currentItinerary                      = [NSMutableArray new];

    self.searchBar.delegate                    = self;
    self.itineraryTableView.delegate           = self;
    self.itineraryTableView.dataSource         = self;
    self.autocompleteTableView.delegate        = self;
    self.autocompleteTableView.dataSource      = self;

    self.autocompleteTableView.backgroundColor = [UIColor greenSeaColor];
    self.itineraryTableView.backgroundColor    = [UIColor wisteriaColor];
    
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
    if ([tableView isEqual:self.itineraryTableView]) {
        return self.currentItinerary.count;
    }
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
    
    if ([tableView isEqual:self.itineraryTableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:itineraryCellReuseID forIndexPath:indexPath];
        HNKGooglePlacesAutocompletePlace *daPlace = (HNKGooglePlacesAutocompletePlace*)self.currentItinerary[indexPath.row];
        cell.textLabel.text = daPlace.name;
    }
    return cell;
}

#pragma mark - TableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.autocompleteTableView]) {
        [self.currentItinerary addObject:self.searchResults[indexPath.row]];
        [self.itineraryTableView reloadData];
        [self.searchBar.delegate searchBarCancelButtonClicked:self.searchBar]; //Because you want the same functionality to happen.
    }
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     self.tourObject.tourItinerary = self.currentItinerary;
     
     
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


@end
