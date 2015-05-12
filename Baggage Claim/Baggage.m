//
//  Baggage.m
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/3/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import "Baggage.h"

@implementation Baggage

-(instancetype) initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    self.name = [decoder decodeObjectForKey:@"name"];
    self.uuid = [decoder decodeObjectForKey:@"uuid"];
    self.majorValue =  [decoder decodeIntForKey:@"majorValue"];
    self.minorValue =  [decoder decodeIntForKey:@"minorValue"];
    self.photoPath = [decoder decodeObjectForKey:@"photoPath"];
    self.hasArrived = [decoder decodeBoolForKey:@"hasArrived"];
    self.hasNotificationBeenSent = [decoder decodeBoolForKey:@"hasNotificationBeenSent"];

    return self;
}

-(void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.uuid forKey:@"uuid"];
    [encoder encodeInt:self.majorValue forKey:@"majorValue"];
    [encoder encodeInt:self.minorValue forKey:@"minorValue"];
    [encoder encodeObject:self.photoPath forKey:@"photoPath"];
    [encoder encodeBool:self.hasArrived forKey:@"hasArrived"];
    [encoder encodeBool:self.hasNotificationBeenSent forKey:@"hasNotificationBeenSent"];
}

@end
