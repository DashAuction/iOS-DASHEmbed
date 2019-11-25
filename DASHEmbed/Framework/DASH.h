//
//  DASH.h
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DASHConfig, DASHViewController;
@interface DASH : NSObject

+ (instancetype)team;

- (void)startWithConfig:(DASHConfig *)config;

- (void)setUserEmail:(NSString *)userEmail;
- (void)clearUserEmail;

- (void)setUserPushTokenWithData:(NSData *)data;
- (void)setUserPushTokenWithString:(NSString *)string;
- (void)clearPushToken;

- (BOOL)canHandleNotification:(UNNotification *)notification;
- (void)setNotificationDataFromNotification:(UNNotification *)notification;
- (BOOL)hasNotificationData;
- (void)clearNotificationData;

- (nullable DASHViewController *)dashViewController;

@end

NS_ASSUME_NONNULL_END
