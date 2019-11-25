//
//  NSBundle+NSBundle_DASHAdditions.m
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import "NSBundle+DASHAdditions.h"
#import <UIKit/UIKit.h>
#import "DASH.h"

@implementation NSBundle (DASHAdditions)

- (nullable NSBundle *)frameworkResourceBundle {
#ifdef FRAMEWORK
    NSBundle *currentBundle = [NSBundle mainBundle];
#else
    NSBundle *currentBundle = [NSBundle bundleForClass:[DASH class]];
#endif
    NSURL *bundleURL = [currentBundle URLForResource:@"DASHEmbed" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    return resourceBundle;
}

@end
