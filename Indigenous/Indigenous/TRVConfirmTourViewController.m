//
//  TRVConfirmTourViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//
#import <Parse.h>
#import "TRVConfirmTourViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <HNKGooglePlacesAutocomplete.h>
#import <CLPlacemark+HNKAdditions.h>
#import <RMSaveButton.h>
#import "TRVConstants.h"
#import <AddressBookUI/AddressBookUI.h>


@interface TRVConfirmTourViewController ()

@end

@implementation TRVConfirmTourViewController

static NSString * const cellReuseID = @"cellReuseID";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tourNameLabel.text = self.tourObject.tourName;
    self.tourCategoryLabel.text = self.tourObject.tourCategory;
    self.tourAreaLabel.text/*TODO*/;
    self.tourImageView.image = self.tourObject.tourImage;
    
    self.finalItineraryTableView.delegate = self;
    self.finalItineraryTableView.dataSource = self;
}

#pragma mark - TableviewDelegate and Datasource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tourObject.tourItinerary.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    
        cell.textLabel.text = ((HNKGooglePlacesAutocompletePlace*)self.tourObject.tourItinerary[indexPath.row]).name;
    return cell;
}


//    ✅
-(void)createParseTourWithName:(NSString*)tourName
                      category:(NSString*)tourCategory
                          date:(NSDate  *)departureDate
                         image:(UIImage *)localTourImage
                     itinerary:(NSArray *)arrayOfHNKLocations {
//    ✅
    PFUser *currentUser = [PFUser currentUser];
    PFObject *theTour   = [PFObject objectWithClassName:@"Tour"];
    [theTour setObject:currentUser forKey:@"guideForThisTour"];
//    ✅
    PFObject *theItinerary           = [PFObject objectWithClassName:@"Itinerary"];
    theItinerary[@"nameOfTour"]      = tourName;
    theTour[@"categoryForThisTour"]  = tourCategory;
    theTour[@"tourDeparture"]        = departureDate;
    UIImage *tourImage               = tourImage;
    theTour[@"itineraryForThisTour"] = theItinerary;
    
//    ✅
        //This gets the GooglePlace overload, and makes it nice NSStrings
     __block NSMutableArray *arrayOfPlacemarks;
        for (HNKGooglePlacesAutocompletePlace *place in arrayOfHNKLocations) {
            [CLPlacemark hnk_placemarkFromGooglePlace:place
                                               apiKey:GOOGLE_API_KEY2
                                           completion:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
                                               if (error) {
                                                   NSLog(@"Error in CLPlacemark+hnk: %@", error.localizedDescription);
                                               } else {
                                                   [arrayOfPlacemarks addObject:placemark];
                                               }
                                           }];
        }
    
    //    ✅
        //Then we turn the placemarks into PFObjects!
    for (CLPlacemark *placemark in arrayOfPlacemarks) {
        PFObject *theStop = [PFObject objectWithClassName:@"TourStop"];
        theStop[@"operatorCost"]    = @0;
        theStop[@"incidentalCost"]  = @0;
        theStop[@"coordinatePoint"] = [PFGeoPoint geoPointWithLocation:placemark.location];
//        theStop[@"lat"]             = placemark.location.coordinate.latitude;
//        theStop[@"lng"]             = placemark.location.coordinate.longitude;
        theStop[@"nameOfPlace"] = placemark.name; //e.g., Apple Inc.
        theStop[@"addressOfEvent"] = ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO);
            //TODO give the user a place to add notes to each stop.
        theStop[@"descriptionOfEvent"] = @"We will be running through the six with our woes.  You know how that goes.";
        
            // MAKE SURE THAT THIS IS A PFFILE.   LOOK AT ABOVE CODE WHICH TAKES NSDATA AND CONVERTS TO PFFILE.
            // CURRENTLY USING PFIMAGE FROM LINE 18, BUT WE WANT A NEW STOP IMAGE.  REPEAT PROCESS FROM
            // LINE 15 - 18
        /**
         *  TODO - Local TourStopImage
         *
         *  @param localTourImage <#localTourImage description#>
         *  @param .2f            <#.2f description#>
         *
         *  @return <#return value description#>
         */
        NSData *imageData = UIImageJPEGRepresentation(tourStopImage, .2f);
        PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
         theStop[@"image"] = PFImage;

        [tourStopsArray addObject:theStop];
    } //Loop ends
//    ===============================================================
    /**
     *  Now we should have an array of tourstops.
     */
    

    /**
     *  From here until ||    theStop[@"image"] = PFImage; || is done for each tourStop.
     */
        //!!!These 4 lines are done for each image.
        // converts tour image to 1/5 quality
    NSData *imageData = UIImageJPEGRepresentation(localTourImage, .2f);
    PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
    theItinerary[@"tourImage"] = PFImage;
    /**
     *  for later:
     */
//    theStop[@"operatorCost"] = @0;
//    theStop[@"incidentalCost"] = @0;
//    theStop[@"lat"] = @10;
//    theStop[@"lng"] = @10;
//    theStop[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
    /**
     *  important!
     */
   
    
    theItinerary[@"tourStops"] = tourStopsArray;
    theItinerary[@"numberOfStops"] = @(tourStopsArray.count);
    
    
    [theTour saveInBackgroundWithBlock:^(BOOL success, NSError *error){
        NSLog(@"THE TOUR ID IS: %@", theTour.objectId);
        
        [currentUser addObject:theTour forKey:@"myTrips"];
        [currentUser saveInBackgroundWithBlock:^(BOOL success, NSError *error){
            if (error){
                NSLog(@"Cant save to array because: %@", error);
            } else {
                NSLog(@"Successfully added stuff to array.");
            }
        }];
        
        
    }];
    
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

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
