//
//  DASH.m
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import "DASH.h"
#import "DASHConfig.h"
#import "DASHViewController.h"

@interface DASH()

@property (nonatomic, strong) DASHConfig *config;
@property (nonatomic, strong) NSString *pushTokenString;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSDictionary<NSString *, NSObject> *currentNotificationData;
@property (nonatomic, weak) DASHViewController *currentDashViewController;

@end

@implementation DASH

#pragma mark - Public

- (void)startWithConfig:(DASHConfig *)config {
    
}

- (void)setUserEmail:(NSString *)userEmail {
    
}

- (void)clearUserEmail {
    
}

- (void)setUserPushTokenWithData:(NSData *)data {
    
}

- (void)setUserPushTokenWithString:(NSString *)string {
    
}

- (void)clearPushToken {
    
}

- (BOOL)canHandleNotification:(UNNotification *)notification {
    return NO;
}

- (void)setNotificationDataFromNotification:(UNNotification *)notification {
    
}

- (BOOL)hasNotificationData {
    return self.currentNotificationData != nil;
}

- (void)clearNotificationData {
    
}

- (nullable DASHViewController *)dashViewController {
    return nil;
}

#pragma mark - Private

- (void)cacheString:(NSString *)string forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (string) {
        [defaults set]
    }
}

- (NSString *)cachedStringForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:key];
}

@end
