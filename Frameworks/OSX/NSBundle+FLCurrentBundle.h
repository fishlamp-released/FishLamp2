//
//  NSBundle+FLCurrentBundle.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/30/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (FLCurrentBundle)

+ (NSBundle*) currentBundle;

+ (void) pushCurrentBundle:(NSBundle*) bundle;
+ (void) popCurrentBundle;

@end
