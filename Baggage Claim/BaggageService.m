//
//  BaggageService.m
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/7/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import "BaggageService.h"

@implementation BaggageService

+(NSMutableArray *) getAll {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *baggages =  [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults valueForKey:@"Baggages"]];
    return baggages;
    
}

+(void) save:(Baggage *)baggage {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *baggages = [BaggageService getAll];
    
    if(baggages == nil) {
        
        baggages = [NSMutableArray array];
    }
    
    [baggages addObject:baggage];
    
    NSData *archivedBaggages = [NSKeyedArchiver archivedDataWithRootObject:baggages];
    
    [userDefaults setObject:archivedBaggages forKey:@"Baggages"];
    [userDefaults synchronize];
}

+(void) delete:(Baggage *) baggage {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *baggages = [BaggageService getAll];
    
    Baggage *baggageToBeDeleted = [[baggages filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.majorValue = %d && SELF.minorValue = %d",baggage.majorValue,baggage.minorValue]] firstObject];
    
    [baggages removeObject:baggageToBeDeleted];
    
    NSData *archivedBaggages = [NSKeyedArchiver archivedDataWithRootObject:baggages];
    
    [userDefaults setObject:archivedBaggages forKey:@"Baggages"];
    [userDefaults synchronize];
    
}

+(void) update:(Baggage *) baggage {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *baggages = [BaggageService getAll];
    
    Baggage *persistedBaggage = [[baggages filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.majorValue = %d && SELF.minorValue = %d",baggage.majorValue,baggage.minorValue]] firstObject];
    
    if(persistedBaggage != nil) {
        
        [baggages removeObject:persistedBaggage];
        
        NSData *archivedBaggages = [NSKeyedArchiver archivedDataWithRootObject:baggages];
        
        [userDefaults setObject:archivedBaggages forKey:@"Baggages"];
        [userDefaults synchronize];
    }
    
    [BaggageService save:baggage];
}

@end
