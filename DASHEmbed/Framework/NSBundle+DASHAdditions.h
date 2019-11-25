//
//  NSBundle+NSBundle_DASHAdditions.h
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (DASHAdditions)

- (nullable NSBundle *)frameworkResourceBundle;

@end

NS_ASSUME_NONNULL_END
