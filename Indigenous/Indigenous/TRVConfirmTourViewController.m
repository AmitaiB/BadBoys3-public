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


@interface TRVConfirmTourViewController ()

@end

@implementation TRVConfirmTourViewController

static NSString * const cellReuseID = @"cellReuseID";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tourNameLabel.text = self.tourObject.tourName;
    self.tourCategoryLabel.text = self.tourObject.tourCategory;
    self.tourAreaLabel.text/*TODO*/;
    self.tourImageView.image = self.tourObject.tourImage;
    
    self.finalItineraryTableView.delegate = self;
    self.finalItineraryTableView.dataSource = self;
    
    self.isGeocoded = NO;
    
    
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
    
//    if (self.isGeocoded) {
        cell.textLabel.text = ((HNKGooglePlacesAutocompletePlace*)self.tourObject.tourItinerary[indexPath.row]).name;
//    } cell.textLabel.text = self.tourObject.tourItinerary;
//    
    return cell;
}

-(void)geocodeMe {
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:@"" completionHandler:^(NSArray *placemarks, NSError *error) {
        
        
    }];
    

    [geocoder reverseGeocodeLocation:nil completionHandler:^(NSArray *placemarks, NSError *error) {
        
        
    

    /**
     *  deprecated sample error message
     */
    if (error)
    {
//        [self.latitudeTextField setText:@"Not found"];
//        [self.longitudeTextField setText:@"Not found"];
//        
//        UIAlertView *alert =
//        [[UIAlertView alloc] initWithTitle:@"Geocoding Error"
//                                   message:error.localizedDescription
//                                  delegate:nil
//                         cancelButtonTitle:@"OK"
//                         otherButtonTitles: nil];
//        
//        [alert show];

        
        /**
         *  deprecated sample success completion block
         */
        if ([placemarks count] > 0) {
//            CLPlacemark *placemark = [placemarks lastObject];
//            
//            NSString *latString =
//            [NSString stringWithFormat:@"%f",
//             placemark.location.coordinate.latitude];
//            
//            [self.latitudeTextField setText:latString];
//            
//            NSString *longString =
//            [NSString stringWithFormat:@"%f",
//             placemark.location.coordinate.longitude];
//            
//            [self.longitudeTextField setText:longString];
        }
    }
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
        

//    ✅
-(void)createParseTourWithName:(NSString*)tourName category:(NSString*)tourCategory date:(NSDate*)departureDate image:(UIImage*)localTourImage itinerary:(NSArray*)arrayOfHNKLocations {
//    ✅
    PFUser *currentUser = [PFUser currentUser];
    PFObject *theTour = [PFObject objectWithClassName:@"Tour"];
    [theTour setObject:currentUser forKey:@"guideForThisTour"];
//    ✅
    PFObject *theItinerary = [PFObject objectWithClassName:@"Itinerary"];
    theItinerary[@"nameOfTour"] = tourName;
    theTour[@"categoryForThisTour"] = tourCategory;
    theTour[@"tourDeparture"] = departureDate;
    UIImage *tourImage = tourImage;
    theTour[@"itineraryForThisTour"] = theItinerary;
    
    
        //This gets the GooglePlace overload → NSStrings
    NSMutableArray *arrayOfGenericAddresses;
        for (HNKGooglePlacesAutocompletePlace *place in arrayOfHNKLocations) {
            [arrayOfGenericAddresses addObject:place.name];
        }
    
    
    NSMutableArray *tourStopsArray;
    for (NSString *address in tourStopsArray) {
        PFObject *theStop = [PFObject objectWithClassName:@"TourStop"];
        /**
         *  for later:
//         */
//                theStop[@"operatorCost"] = @0;
//                theStop[@"incidentalCost"] = @0;
//                theStop[@"lat"] = @10;
//                theStop[@"lng"] = @10;
//                theStop[@"coordinatePoint"] = [PFGeoPoint geoPointWithLatitude:10.0 longitude:10.0];
        /**
         *  important!
         */
        theStop[@"nameOfPlace"] = @"GEOCODE ME A REAL PLACE NAME";
            //TODO give the user a place to add notes to each stop.
        theStop[@"descriptionOfEvent"] = @"We will be running through the six with our woes.  You know how that goes.";
        theStop[@"addressOfEvent"] = address;
        
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
        !!!NSData *imageData = UIImageJPEGRepresentation(localTourImage, .2f);
        PFFile *PFImage = [PFFile fileWithName:theItinerary[@"nameOfTour"] data:imageData];
         theStop[@"image"] = PFImage;
         */

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
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
