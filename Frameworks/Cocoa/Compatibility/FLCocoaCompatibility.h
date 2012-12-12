//
//  FLCompatibility.h
//  FLCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

// These are macros that define CocoaX for compatibility between iOS and Mac
// for some common actions. Note that more specific code will still need to 
// be conditionally compiled. This is just for the more common cases and 
// for compatibility with utility functions - like in FLRectGeometry.h

#import "FLCore.h"

#if IOS
    #define DeviceIsMac()   NO
#endif

#if OSX
    #define UIEdgeInsets                        NSEdgeInsets
    #define UIEdgeInsetsMake                    NSEdgeInsetsMake
    #define UIEdgeInsetsEqualToEdgeInsets       NSEdgeInsetsEqualToEdgeInsets
    #define UIEdgeInsetsInsetRect               NSEdgeInsetsInsetRect
    extern  const NSEdgeInsets                  UIEdgeInsetsZero;
    // these don't exist in AppKit ?? 

    NS_INLINE
    BOOL UIEdgeInsetsEqualToEdgeInsets(NSEdgeInsets lhs, NSEdgeInsets rhs) {
        return  FLFloatEqualToFloat(lhs.top, rhs.top) &&
                FLFloatEqualToFloat(lhs.bottom, rhs.bottom) &&
                FLFloatEqualToFloat(lhs.left, rhs.left) &&
                FLFloatEqualToFloat(lhs.right, rhs.right);
    }

    NS_INLINE
    NSRect  UIEdgeInsetsInsetRect(NSRect rect, NSEdgeInsets insets) {
        rect.origin.x    += insets.left;
        rect.origin.y    += insets.top;
        rect.size.width  -= (insets.left + insets.right);
        rect.size.height -= (insets.top  + insets.bottom);
        return rect;
    }

    #define UIColor                     NSColor
    #define UIFont                      NSFont
    
    #define UIEvent                    NSEvent

    #define DeviceIsMac()   YES
    #define DeviceIsPad()   NO
    #define DeviceIsPhone() NO
    #define DeviceIsPod()   NO
    #define DeviceIsSimulator() NO

    #define CGSizeFromString            NSSizeFromString
    #define NSStringFromCGSize          NSStringFromSize
    
    #define CGRectFromString            NSRectFromString
    #define NSStringFromCGRect          NSStringFromRect
    
    #define CGPointFromString           NSPointFromString
    #define NSStringFromCGPoint         NSStringFromPoint


    #import "NSImage+FLCompatibility.h"
    #import "NSValue+FLCompatibility.h"

#endif

// sdk categories

