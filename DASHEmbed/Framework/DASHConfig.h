//
//  DASHConfig.h
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DASHConfig : NSObject

@property (nonatomic, strong, readonly) NSString *appId;
@property (nonatomic, readonly) BOOL useDevelopmentServers;

- (instancetype)initWithAppId:(NSString *)appId; //Defaults to production
- (instancetype)initWithAppId:(NSString *)appId useDevelopmentServers:(BOOL)useDevelopmentServers;

@end

NS_ASSUME_NONNULL_END
