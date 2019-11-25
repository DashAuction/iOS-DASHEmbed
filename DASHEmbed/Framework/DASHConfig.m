//
//  DASHConfig.m
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import "DASHConfig.h"

@implementation DASHConfig

- (instancetype)initWithAppId:(NSString *)appId {
    return [self initWithAppId:appId useDevelopmentServers:YES];
}

- (instancetype)initWithAppId:(NSString *)appId useDevelopmentServers:(BOOL)useDevelopmentServers {
    self = [super init];
    if (self) {
        _appId = appId;
        _useDevelopmentServers = useDevelopmentServers;
    }
    
    return self;
}

@end
