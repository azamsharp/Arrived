//
//  AppDelegate.m
//  Baggage Claim
//
//  Created by Mohammad AZam on 4/21/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "Baggage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self updateBaggageForNotification:launchOptions];
    
    [self askForPermissions];
    [self setup];
    
    
    return YES;
}

-(void) updateBaggageForNotification:(NSDictionary *) userInfo {
    
    NSData *baggageData =  [userInfo valueForKey:@"Baggage"];
    
    if(baggageData != nil) {
        
        Baggage *baggage = (Baggage *) [NSKeyedUnarchiver unarchiveObjectWithData:baggageData];
        baggage.hasArrived = NO;
        baggage.hasNotificationBeenSent = YES;
        
        [BaggageService update:baggage];
        
        NSMutableArray *baggages = [BaggageService getAll];
        int noOfArrivedBaggages = [[baggages filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.hasArrived = YES"]] count];
        
        if(noOfArrivedBaggages == 0) {
         
          //  [[UIApplication sharedApplication] setApplicationIconBadgeNumber:-1];
        }
        
    }

}

-(void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [self updateBaggageForNotification:notification.userInfo];
    
    
}

-(void) askForPermissions {
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge
                                                                                                              categories:nil]];
    }

}



-(void) setup {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorFromHexString:@"E53E18"]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} ];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
