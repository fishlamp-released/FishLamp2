//
//  FLEdgeInsets.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>


#if IOS

// IOS

#define FLEdgeInsets                    UIEdgeInsets
#define FLEdgeInsetsZero                UIEdgeInsetsZero
#define FLEdgeInsetsMake                UIEdgeInsetsMake
#define FLEdgeInsetsEqualToEdgeInsets   UIEdgeInsetsEqualToEdgeInsets
#define FLEdgeInsetsAreEqual            UIEdgeInsetsEqualToEdgeInsets
#define FLEdgeInsetsInsetRect           UIEdgeInsetsInsetRect

#else

// OSX
#define FLEdgeInsets                    NSEdgeInsets
#define FLEdgeInsetsMake                NSEdgeInsetsMake
#define FLEdgeInsetsEqualToEdgeInsets   FLEdgeInsetsAreEqual
extern  const FLEdgeInsets              FLEdgeInsetsZero;
    
// these don't exist in AppKit ?? 

NS_INLINE
BOOL FLEdgeInsetsAreEqual(NSEdgeInsets lhs, NSEdgeInsets rhs) {
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

#define FLEdgeInsets10                  FLEdgeInsetsMake(10,10,10,10)
#define FLEdgeInsets1                   FLEdgeInsetsMake(1,1,1,1)
