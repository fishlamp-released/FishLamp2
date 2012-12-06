//
//  FLSizeGeometry.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"

#if IOS
    #define SDKSize                   CGSize
    #define FLSizeMake               CGSizeMake
    #define NSStringFromSDKSize       NSStringFromCGSize
    #define FLSizeFromString         CGSizeFromString
    #define FLSizeZero               CGSizeZero
    #define FLSizeEqualToSize        CGSizeEqualToSize
    #define FLEqualSizes             CGSizeEqualToSize
#else
    #define SDKSize                   NSSize
    #define FLSizeMake               NSMakeSize
    #define NSStringFromSDKSize       NSStringFromSize
    #define FLSizeFromString         NSSizeFromString     
    #define FLSizeZero               NSZeroSize
    #define FLSizeEqualToSize        NSEqualSizes
    #define FLEqualSizes             NSEqualSizes
    
#endif