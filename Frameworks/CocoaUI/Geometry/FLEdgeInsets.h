//
//  FLEdgeInsetsUtilities.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLGeometryCompatibility.h"

#if IOS
    #define FLEdgeInsetsZero                   UIEdgeInsetsZero
    #define FLEdgeInsetsMake                   UIEdgeInsetsMake
    #define FLEdgeInsetsEqualToEdgeInsets      UIEdgeInsetsEqualToEdgeInsets
    #define FLEdgeInsetsInsetRect              UIEdgeInsetsInsetRect
#endif

#if OSX
    extern  const NSEdgeInsets                  FLEdgeInsetsZero;
    #define FLEdgeInsetsMake                    NSEdgeInsetsMake

    // these don't exist in AppKit ?? 

    NS_INLINE
    BOOL FLEdgeInsetsEqualToEdgeInsets(NSEdgeInsets lhs, NSEdgeInsets rhs) {
        return  FLFloatEqualToFloat(lhs.top, rhs.top) &&
                FLFloatEqualToFloat(lhs.bottom, rhs.bottom) &&
                FLFloatEqualToFloat(lhs.left, rhs.left) &&
                FLFloatEqualToFloat(lhs.right, rhs.right);
    }

    NS_INLINE
    NSRect FLEdgeInsetsInsetRect(NSRect rect, FLEdgeInsets insets) {
        rect.origin.x    += insets.left;
        rect.origin.y    += insets.top;
        rect.size.width  -= (insets.left + insets.right);
        rect.size.height -= (insets.top  + insets.bottom);
        return rect;
    }
#endif

#define FLEdgeInsets10                         FLEdgeInsetsMake(10,10,10,10)
#define FLEdgeInsets1                          FLEdgeInsetsMake(1,1,1,1)


