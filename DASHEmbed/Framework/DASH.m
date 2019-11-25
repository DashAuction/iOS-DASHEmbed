//
//  DASH.m
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//
//  A DASH instance can be used as an app wide singleton (by using team).
//  It is the main class for interacting with the SDK. Use this instance to handle deep
//  link URLs and to instantiate a view controller to show the DASH interface.

#import "DASH.h"
#import "DASHConfig.h"
#import "DASHViewController.h"
#import "NSData+DASHAdditions.h"
#import "DASHUserInfo.h"

static NSString *const DASHNotificationInfoKey = @"dash";
static NSString *const DASHPushTokenDefaultsKey = @"io.dashapp.dashembed.pushtoken";
static NSString *const DASHUserEmailDefaultsKey = @"io.dashapp.dashembed.useremail";

@interface DASH()

@property (nonatomic, strong) DASHConfig *config;
@property (nonatomic, strong) NSString *pushTokenString;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSDictionary<NSString *, NSObject> *currentNotificationData;
@property (nonatomic, weak) DASHViewController *currentDashViewController;

@end

@implementation DASH

#pragma mark - Public

static DASH *_shared;

/// Singleton use of DASH
+ (instancetype)team
{
    if (!_shared)
        _shared = [[self alloc] init];
    
    return _shared;
}

/// Initializes DASH. Call this once before any other methods.
- (void)startWithConfig:(DASHConfig *)config {
    self.config = config;
    
    //Populate cached values
    self.pushTokenString = [self cachedStringForKey:DASHPushTokenDefaultsKey];
    self.userEmail = [self cachedStringForKey:DASHUserEmailDefaultsKey];
}

/// Sets the current user's email. Email is used to uniquely identify a user in the DASH system. Email is cached locally by DASH for ease of use.
- (void)setUserEmail:(NSString *)userEmail {
    self.userEmail = userEmail;
    [self cacheString:userEmail forKey:DASHUserEmailDefaultsKey];
}

/// Clears out local and cached user email data
- (void)clearUserEmail {
    self.userEmail = nil;
    [self cacheString:nil forKey:DASHUserEmailDefaultsKey];
}

/// Used to set the push device token for the current app. Set this with the data returned from the remote notifications delegate method. This is used to send DASH outbid notifications on the team's behalf. Set each time token changes. Token will be cached locally by DASH for ease of use.
- (void)setUserPushTokenWithData:(NSData *)data {
    NSString *pushString = [data hexString];
    [self setUserPushTokenWithString:pushString];
}

/// Used to set the push device token for the current app if already in string format. This is used to send DASH outbid notifications on the team's behalf. Set each time token changes. Token will be cached locally by DASH for ease of use.
- (void)setUserPushTokenWithString:(NSString *)string {
    self.pushTokenString = string;
    [self cacheString:string forKey:DASHPushTokenDefaultsKey];
}

/// Clears out local and cached push tokens in DASH
- (void)clearPushToken {
    self.pushTokenString = nil;
    [self cacheString:nil forKey:DASHPushTokenDefaultsKey];
}

/// Returns true if the notification passed in should be handled by DASH. If true, you should tell DASH to handle the notification and present the DASH view controller.
- (BOOL)canHandleNotification:(UNNotification *)notification {
    return notification.request.content.userInfo[DASHNotificationInfoKey] != nil;
}

/// Tells DASH to handle the notification. The next presentation of the DASH view controller will handle the notification. If DASH view controller is already presented, this will reload the interface to handle the notification. EX: If a DASH outbid notification is set here, the next presentation will navigate directly to the respective auction item.
- (void)setNotificationDataFromNotification:(UNNotification *)notification {
    NSDictionary<NSString *, NSObject> *notificationData = notification.request.content.userInfo[DASHNotificationInfoKey];
    if (notificationData) {
        self.currentNotificationData = notificationData;
        
        //If we can go ahead and handle the data, handle it then clear it out
        if (self.currentDashViewController) {
            [self.currentDashViewController updateNotificationData:notificationData];
            [self clearNotificationData];
        }
    }
}

/// Returns whether DASH currently has data as result of a notification (and subsequently DASH view controller should be presented)
- (BOOL)hasNotificationData {
    return self.currentNotificationData != nil;
}

/// Clears out the pending notification data provided by handleNotification()
- (void)clearNotificationData {
    self.currentNotificationData = nil;
}

/// Returns a DASH view controller for display. Can be pushed on a navigation stack as is or presented modally when embedded in a UINavigationController
- (nullable DASHViewController *)dashViewController {
    if (!self.config) {
        NSLog(@"DASH must start with config before using DASHViewController");
        return nil;
    }
    
    DASHUserInfo *userInfo = [[DASHUserInfo alloc] initWithPushToken:self.pushTokenString userEmail:self.userEmail];
    DASHViewController *viewController = [DASHViewController instantiateWithConfig:self.config userInfo:userInfo notificationData:self.currentNotificationData];
    self.currentDashViewController = viewController;
    return viewController;
}

#pragma mark - Private

- (void)cacheString:(nullable NSString *)string forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (string) {
        [defaults setObject:string forKey:key];
    } else {
        [defaults removeObjectForKey:key];
    }
}

- (nullable NSString *)cachedStringForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:key];
}

@end
