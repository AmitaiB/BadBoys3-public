//
//  TRVBuildItineraryViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVBuildItineraryViewController.h"
#import <HNKGooglePlacesAutocomplete.h>

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVBuildItineraryViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *autocompleteTableView;
@property (weak, nonatomic) IBOutlet UITableView *itineraryTableView;
@property (weak, nonatomic) IBOutlet UILabel *someLabel;
@property (strong, nonatomic) __block NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableArray *currentItinerary;


@end

@implementation TRVBuildItineraryViewController

static NSString * const searchCellReuseID = @"searchCellReuseID";
static NSString * const itineraryCellReuseID = @"itineraryCellReuseID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    DBLG
    [[HNKGooglePlacesAutocompleteQuery sharedQuery] fetchPlacesForSearchQuery:searchText completion:^(NSArray *places, NSError *error) {
        if (error) {
            NSLog(@"ERROR! %@", error.localizedDescription);
        } else {
            self.searchResults = [places mutableCopy];
        NSLog(@"HNKSearch results: %@", [places description]);
        }
    }];
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
        cell = [tableView dequeueReusableCellWithIdentifier:searchCellReuseID];
        cell.textLabel.text = self.searchResults[indexPath.row];
    }
    
    if ([tableView isEqual:self.itineraryTableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:itineraryCellReuseID];
        cell.textLabel.text = self.currentItinerary[indexPath.row];
    }
    return cell;
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
