//
//  BaggageTableViewCell.h
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/6/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaggageTableViewCell : UITableViewCell
{
    
}

@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UILabel *majorIdLabel;
@property (nonatomic,weak) IBOutlet UILabel *minorIdLabel;
@property (nonatomic,weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic,weak) IBOutlet UILabel *hasArrivedLabel;
@property (nonatomic,weak) IBOutlet UIView *hasArrivedView; 

@end
