//
//  TRVPickCityTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVPickCityTableViewController.h"
#import "TRVCity.h"
#import "TRVCityTableViewCell.h"
#import "TRVUserDataStore.h"
#import <Parse.h>

@interface TRVPickCityTableViewController ()

@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (nonatomic, strong) NSMutableArray *cities;
@end

@implementation TRVPickCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //FOR TESTING PURPOSES ONLY
    //DELETE LATER ON
    if (![PFUser currentUser]){
       [PFUser logInWithUsername:@"joe@g.com" password:@"joe"];
    }
    //DELETE
    //DELETE
    
    self.sharedDataStore = [[TRVUserDataStore alloc] initWithCurrentUser:[PFUser currentUser]];
    self.sharedDataStore.parseUser = [PFUser currentUser];
    
    
    
    TRVCity *newYork = [[TRVCity alloc] initWithName:@"New York City" image:[UIImage imageNamed:@"newyork"]];
    TRVCity *beijing = [[TRVCity alloc] initWithName:@"Beijing" image:[UIImage imageNamed:@"beijing"]];
    TRVCity *london = [[TRVCity alloc] initWithName:@"London" image:[UIImage imageNamed:@"london"]];
    TRVCity *madrid= [[TRVCity alloc] initWithName:@"Madrid" image:[UIImage imageNamed:@"madrid"]];
    
    self.cities = [[NSMutableArray alloc] initWithObjects:newYork, london, madrid, beijing, nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRVCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityReuseCell" forIndexPath:indexPath];
    TRVCity *cityForThisRow = self.cities[indexPath.row];
    cell.cityImageView.image = cityForThisRow.cityImage;
    cell.cityNameLabel.text = cityForThisRow.nameOfCity;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TRVCityTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // pass cell details into next vc...
    
    [self performSegueWithIdentifier:@"showCategoriesSegue" sender:self];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
