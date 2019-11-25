//
//  DASHViewController.h
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DASHViewController;
@protocol DASHViewControllerDelegate <NSObject>

- (void)dashViewController:(DASHViewController *)viewController didFailWithError:(NSError *)error;

@end

@class DASHConfig, DASHUserInfo;
@interface DASHViewController : UIViewController

@property (nonatomic, weak) id<DASHViewControllerDelegate> delegate;

+ (instancetype)instantiateWithConfig:(DASHConfig *)config userInfo:(DASHUserInfo *)userInfo notificationData:(NSDictionary<NSString *, id> *)notificationData;

- (void)updateNotificationData:(NSDictionary<NSString *, id> *)notificationData;
- (void)reloadInterfaceStartFromBeginning:(BOOL)startFromBeginning;

@end

NS_ASSUME_NONNULL_END
