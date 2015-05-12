//
//  BaggageView.h
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/6/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Baggage.h"
#import "ImageService.h"

@interface BaggageView : UIView
{
    
}

-(instancetype) initWithBaggage:(Baggage *) baggage;

@property (nonatomic,strong) UIImageView *photoImageView;
@property (nonatomic,strong) UILabel *nameLabel;

@end
