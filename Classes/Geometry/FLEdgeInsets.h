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
    extern  const FLEdgeInsets              FLEdgeInsetsZero;
#endif

#define FLEdgeInsets10                  FLEdgeInsetsMake(10,10,10,10)
#define FLEdgeInsets1                   FLEdgeInsetsMake(1,1,1,1)
