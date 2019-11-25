//
//  DASHUserInfo.h
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DASHUserInfo : NSObject

@property (nonatomic, strong, readonly) nullable NSString *pushTokenString;
@property (nonatomic, strong, readonly) nullable NSString *userEmail;

- (instancetype)initWithPushToken:(nullable NSString *)pushTokenString userEmail:(nullable NSString *)userEmail;

@end

NS_ASSUME_NONNULL_END
