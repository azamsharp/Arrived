//
//  AddNewBaggageTableViewController.h
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/3/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Baggage.h"
#import "ImageService.h"
#import "BaggageService.h"

@protocol AddNewBaggageTableViewControllerDelegate

-(void) addNewBaggageTableViewControllerDidClose:(UIViewController *) controller;

@end

@interface AddNewBaggageTableViewController : UITableViewController
{
    NSMutableArray *_baggages;
    UIImagePickerController *_imagePicker;
    UIActionSheet *_actionSheet;
}

@property (nonatomic,weak) id<AddNewBaggageTableViewControllerDelegate> delegate;

@end
