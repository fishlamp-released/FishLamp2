//
//  SDKEdgeInsets.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"

//
// IOS
//
#if IOS
    #define SDKEdgeInsets                       UIEdgeInsets
    #define SDKEdgeInsetsZero                   UIEdgeInsetsZero
    #define SDKEdgeInsetsMake                   UIEdgeInsetsMake
    #define SDKEdgeInsetsEqualToEdgeInsets      UIEdgeInsetsEqualToEdgeInsets
    #define SDKEdgeInsetsInsetRect              UIEdgeInsetsInsetRect
#endif


//
// OSX
// 
#if OSX
    #define SDKEdgeInsets                       NSEdgeInsets
    extern  const SDKEdgeInsets                 SDKEdgeInsetsZero;
    #define SDKEdgeInsetsMake                   NSEdgeInsetsMake

    // these don't exist in AppKit ?? 

    NS_INLINE
    BOOL SDKEdgeInsetsEqualToEdgeInsets(NSEdgeInsets lhs, NSEdgeInsets rhs) {
        return  FLFloatEqualToFloat(lhs.top, rhs.top) &&
                FLFloatEqualToFloat(lhs.bottom, rhs.bottom) &&
                FLFloatEqualToFloat(lhs.left, rhs.left) &&
                FLFloatEqualToFloat(lhs.right, rhs.right);
    }

    NS_INLINE
    NSRect SDKEdgeInsetsInsetRect(NSRect rect, SDKEdgeInsets insets) {
        rect.origin.x    += insets.left;
        rect.origin.y    += insets.top;
        rect.size.width  -= (insets.left + insets.right);
        rect.size.height -= (insets.top  + insets.bottom);
        return rect;
    }
#endif

#define SDKEdgeInsetsAreEqual            SDKEdgeInsetsEqualToEdgeInsets
#define SDKEdgeInsets10                  SDKEdgeInsetsMake(10,10,10,10)
#define SDKEdgeInsets1                   SDKEdgeInsetsMake(1,1,1,1)
