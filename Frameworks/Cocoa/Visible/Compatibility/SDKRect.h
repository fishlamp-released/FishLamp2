//
//	SDKRect.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"

#if IOS
    #if DEBUG
        #define CGRectInset             FLRectInset
    #else
        #define FLRectInset             CGRectInset
    #endif
    
    #define SDKRect                     CGRect
    #define FLRectMake                  CGRectMake
    #define FLRectFromString            CGRectFromString
    #define FLRectIntegral              CGRectIntegral
    #define FLRectGetMidX               CGRectGetMidX
    #define FLRectGetMidY               CGRectGetMidY
    #define FLRectInsetWithEdgeInsets   UIEdgeInsetsInsetRect
    #define FLRectEqualToRect           CGRectEqualToRect
    #define FLRectZero                  CGRectZero
    #define NSStringFromSDKRect         NSStringFromCGRect
#endif    


#if OSX
    #if DEBUG
        #define NSRectInset             FLRectInset
    #else
        #define FLRectInset             NSRectInset
    #endif
    
    #define NSStringFromSDKRect         NSStringFromRect
    #define SDKRect                     NSRect
    #define FLRectFromString            NSRectFromString
    #define FLRectMake                  NSMakeRect
    #define FLRectIntegral              NSIntegralRect
    #define FLRectGetMidX               NSMidX
    #define FLRectGetMidY               NSMidY
    #define FLRectEqualToRect           NSEqualRects
    #define FLRectZero                  NSZeroRect
    
#endif
