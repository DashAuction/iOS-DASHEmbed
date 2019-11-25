//
//  DASHUserInfo.m
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import "DASHUserInfo.h"

@implementation DASHUserInfo

- (instancetype)initWithPushToken:(NSString *)pushTokenString userEmail:(NSString *)userEmail {
    self = [super init];
    if (self) {
        _pushTokenString = pushTokenString;
        _userEmail = userEmail;
    }
    
    return self;
}

@end
