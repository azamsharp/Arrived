//
//  Baggage.h
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/3/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface Baggage : NSObject<NSCoding>
{
    
}

@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSUUID *uuid;
@property (nonatomic,assign) int majorValue;
@property (nonatomic,assign) int minorValue;
@property (nonatomic,copy) NSString *photoPath;
@property (nonatomic,assign) BOOL hasArrived;
@property (nonatomic,assign) BOOL hasNotificationBeenSent; 

@end
