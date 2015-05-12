//
//  BaggageView.m
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/6/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import "BaggageView.h"

@implementation BaggageView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    return self;
}

-(instancetype) initWithBaggage:(Baggage *)baggage {
    
    self = [super init];
    
    self.photoImageView = [[UIImageView alloc] initWithImage:[ImageService loadImageFromDocumentsDirectory:baggage.photoPath]];
    self.photoImageView.frame = CGRectMake(10, 0, 300, 300);
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = baggage.name;
    
    [self addSubview:self.photoImageView];
    [self addSubview:self.nameLabel];
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
