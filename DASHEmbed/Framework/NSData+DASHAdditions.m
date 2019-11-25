//
//  NSData+DASHAdditions.m
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import "NSData+DASHAdditions.h"

@implementation NSData (DASHAdditions)

- (NSString *)hexString {
    const char *data = [self bytes];
    NSMutableString *token = [NSMutableString string];

    for (NSUInteger i = 0; i < [deviceToken length]; i++) {
        [token appendFormat:@"%02.2hhx", data[i]];
    }

    return [token copy];
}

@end
