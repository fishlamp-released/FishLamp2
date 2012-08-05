//
//  FLEdgeInsets.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>


#if IOS
    #define FLEdgeInsets                    UIEdgeInsets
    #define FLEdgeInsetsZero                UIEdgeInsetsZero
    #define FLEdgeInsetsMake                UIEdgeInsetsMake
    #define FLEdgeInsetsEqualToEdgeInsets   UIEdgeInsetsEqualToEdgeInsets
    #define FLEdgeInsetsAreEqual            UIEdgeInsetsEqualToEdgeInsets
    #define FLEdgeInsetsInsetRect           UIEdgeInsetsInsetRect

#else

#define FLEdgeInsets                    NSEdgeInsets
#define FLEdgeInsetsMake                NSEdgeInsetsMake
#define FLEdgeInsetsEqualToEdgeInsets   FLEdgeInsetsAreEqual
extern  const FLEdgeInsets              FLEdgeInsetsZero;
    
// these don't exist in AppKit ?? 

NS_INLINE
BOOL FLEdgeInsetsAreEqual(NSEdgeInsets lhs, NSEdgeInsets rhs) {
    return  lhs.top == rhs.top &&
            lhs.bottom == rhs.bottom &&
            lhs.right == rhs.right &&
            lhs.left == rhs.left;
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
