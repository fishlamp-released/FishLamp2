//
//  UIColor.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

#define UIColor                     NSColor

@interface NSColor (FLCompatibility)
+ (NSColor*) colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
@end

#endif
