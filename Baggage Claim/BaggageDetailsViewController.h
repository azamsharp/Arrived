//
//  BaggageDetailsViewController.h
//  Arrived
//
//  Created by Mohammad AZam on 5/13/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Baggage.h"

@protocol BaggageDetailsViewControllerDelegate

-(void) baggageDetailsViewControllerDidStopMonitoring:(UIViewController *)controller baggage:(Baggage *) baggage;

-(void) baggageDetailsViewControllerDidStartMonitoring:(UIViewController *)controller baggage:(Baggage *) baggage;

@end

@interface BaggageDetailsViewController : UIViewController
{
    
}

@property (nonatomic,strong) Baggage *baggage;

@end
