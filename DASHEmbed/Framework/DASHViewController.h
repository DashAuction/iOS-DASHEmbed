//
//  DASHViewController.h
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DASHConfig, DASHUserInfo;
@interface DASHViewController : UIViewController

+ (instancetype)instantiateWithConfig:(DASHConfig *)config userInfo:(DASHUserInfo *)userInfo notificationData:(NSDictionary<NSString *, NSObject> *)notificationData;

- (void)updateNotificationData:(NSDictionary<NSString *, NSObject> *)notificationData;
- (void)reloadInterfaceStartFromBeginning:(BOOL)startFromBeginning;

@end

NS_ASSUME_NONNULL_END
