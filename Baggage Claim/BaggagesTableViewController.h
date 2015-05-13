//
//  BaggagesTableViewController.h
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/6/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Baggage.h"
#import "BaggageTableViewCell.h"
#import "ImageService.h"
#import "AddNewBaggageTableViewController.h"
#import "BaggageService.h"
#import "UIColor+Additions.h"
#import "BaggageDetailsViewController.h"

@import CoreLocation;

@interface BaggagesTableViewController : UITableViewController
{
    NSMutableArray *_baggages; 
}

@property (nonatomic,strong) CLLocationManager *locationManager;

@end
