//
//  AppDelegate.m
//  NewsFeed_sugarain
//
//  Created by SBHR on 2015. 10. 3..
//  Copyright © 2015년 seungbin.baik. All rights reserved.
//

#import "AppDelegate.h"
#import "NFSRLoginViewController.h"
#import "SRManager.h"
#import "SRManagerKit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
      [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // APNS
    application.applicationIconBadgeNumber = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIUserNotificationSettings *notiType = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert |
                                                UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:notiType];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    if(launchOptions!=nil){
        NSString *msg = [NSString stringWithFormat:@"%@", launchOptions];
        NSLog(@" %@",msg);
        
    }
    return YES;
    
    
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    NSLog(@"deviceToken: %@", deviceToken);
    NSString *stringToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    stringToken = [stringToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[SRXMLRPCManager sharedManager] requestInitializeWithDeviceId:[SRSettingsManager sharedManager].device_id
                                                             token:stringToken
                                                        deviceType:@"I"
                                                             alarm:@"Y"
                                                          isForced:NO
                                                    successHandler:^(id XMLData) {
                                                        [[SRSettingsManager sharedManager] getInfoFromServer];
                                                    } failHandler:^(NSError *error, id XMLData) {
                                                        
                                                    }];

}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    NSLog(@"Failed to register with error : %@", error);
    static NSString *emptyStringToken = @"empty";
    [[SRXMLRPCManager sharedManager] requestInitializeWithDeviceId:[SRSettingsManager sharedManager].device_id
                                                             token:emptyStringToken
                                                        deviceType:@"I"
                                                             alarm:@"N"
                                                          isForced:NO
                                                    successHandler:^(id XMLData) {
                                                        [[SRSettingsManager sharedManager] getInfoFromServer];
                                                    } failHandler:^(NSError *error, id XMLData) {
                                                        
                                                    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSString *string = [NSString stringWithFormat:@"%@", userInfo];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:string delegate:nil
                                          cancelButtonTitle:@"OK"   otherButtonTitles:nil];
    [alert show];
    
    
}

- (void) setApplicationBadgeCount:(NSInteger)badgeCount {
    if (badgeCount < 0)
        badgeCount = 0;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = badgeCount;
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
