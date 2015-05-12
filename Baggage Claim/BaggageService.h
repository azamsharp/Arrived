//
//  BaggageService.h
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/7/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baggage.h"

@interface BaggageService : NSObject

+(NSMutableArray *) getAll;
+(void) save:(Baggage *) baggage;
+(void) update:(Baggage *) baggage;
+(void) delete:(Baggage *) baggage;


@end
