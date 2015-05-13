//
//  BaggagesTableViewController.m
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/6/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import "BaggagesTableViewController.h"

@interface BaggagesTableViewController ()<CLLocationManagerDelegate,AddNewBaggageTableViewControllerDelegate>

@end

@implementation BaggagesTableViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setup];
}

-(void) setup {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self setupAuthorization];
    
    _baggages = [BaggageService getAll];
    
    // add observer for _baggages
    
    [self setupBeacons];
    [self.tableView reloadData];
}


-(void) setupAuthorization {
    
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
}

-(void) setupBeacons {
    
    for(Baggage *baggage in _baggages) {
        
        [self startMonitoringBaggage:baggage];
    }
}

-(void) addNewBaggageTableViewControllerDidClose:(UIViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _baggages = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults valueForKey:@"Baggages"]];
       
        [self setupBeacons];
        
        [self.tableView reloadData];
        
    });
}

-(CLBeaconRegion *) beaconRegionWithBaggage:(Baggage *) baggage {
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:baggage.uuid major:baggage.majorValue minor:baggage.minorValue identifier:baggage.name];
    
    return beaconRegion;
}

-(void) startMonitoringBaggage:(Baggage *) baggage {
    
    CLBeaconRegion *beaconRegion = [self beaconRegionWithBaggage:baggage];
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        Baggage *baggage = [_baggages objectAtIndex:indexPath.row];
        [BaggageService delete:baggage];
        
        _baggages = [BaggageService getAll];
        
        [self.tableView reloadData];
    }
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

-(void) stopMonitoringBaggage:(Baggage *) baggage {
    
    CLBeaconRegion *beaconRegion = [self beaconRegionWithBaggage:baggage];
    
    [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
    [self.locationManager stopMonitoringForRegion:beaconRegion];
}

-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
   
    // I am not implementing this method because didEnterRegion
    // takes sometime to trigger. This time can be 2 - 10 minutes depending on the
    // device! 
}

-(void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
    CLBeaconRegion *beaconRegion = (CLBeaconRegion *) region;
    
    Baggage *baggage = [self baggageByMajorIdAndMinorId:beaconRegion.major.intValue minor:beaconRegion.minor.intValue];
    
    baggage.hasArrived = NO;
    
    [BaggageService update:baggage];
    
    [self.tableView reloadData];
}

-(void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    // search in beacons
    
    if(beacons.count == 0) return;
    
    Baggage *baggage = [self baggageByMajorIdAndMinorId:region.major.intValue minor:region.minor.intValue];
    
    if(!baggage.hasArrived) {
        
        baggage.hasArrived = YES;
        [BaggageService update:baggage];
        
        [self sendNotification:baggage];
        
        [self.tableView reloadData];
    }
}

-(Baggage *) baggageByMajorIdAndMinorId:(int) majorId minor:(int) minorId {
   
    _baggages = [BaggageService getAll];
    
    return [[_baggages filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.majorValue = %d && SELF.minorValue = %d",majorId,minorId]] firstObject];
}

-(void) sendNotification:(Baggage *) baggage {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = [NSString stringWithFormat:@"%@ has arrived!",baggage.name];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.userInfo = @{@"Baggage":[NSKeyedArchiver archivedDataWithRootObject:baggage]};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // update the baggage count
    int noOfArrivedBaggages = [[_baggages filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.hasArrived = YES"]] count];
    
   // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:noOfArrivedBaggages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"failed with error");
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"AddNewBaggageSegue"]) {
        
        UINavigationController *navigationViewController = (UINavigationController *) segue.destinationViewController;
        AddNewBaggageTableViewController *addNewBaggageTableViewController = (AddNewBaggageTableViewController *)[[navigationViewController viewControllers] objectAtIndex:0];
        
        addNewBaggageTableViewController.delegate = self;
        
    }
    else if([segue.identifier isEqualToString:@"BaggageDetailsSegue"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Baggage *baggage = [_baggages objectAtIndex:indexPath.row];
        
        UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
        BaggageDetailsViewController *baggageDetailsViewController = [[navigationController viewControllers] objectAtIndex:0];
        baggageDetailsViewController.baggage = baggage;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _baggages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BaggageTableViewCell *cell = (BaggageTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"BaggageCell" forIndexPath:indexPath];
    
    Baggage *baggage = [_baggages objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = baggage.name;
    
    [cell.photoImageView setImage:[ImageService loadImageFromDocumentsDirectory:baggage.photoPath]];
    
    cell.majorIdLabel.text = [NSString stringWithFormat:@"Major Id %d",baggage.majorValue];
    cell.minorIdLabel.text = [NSString stringWithFormat:@"Minor Id %d",baggage.minorValue];
    
    if(baggage.hasArrived) {
        cell.hasArrivedView.backgroundColor = [UIColor colorFromHexString:@"39E54D"];
        cell.hasArrivedLabel.text = @"ARRIVED";
    }
    else {
        cell.hasArrivedView.backgroundColor = [UIColor redColor];
        cell.hasArrivedLabel.text = @"DEPARTED";
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

@end
