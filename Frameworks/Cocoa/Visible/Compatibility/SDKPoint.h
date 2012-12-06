//
//	SDKPoint.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"

#if IOS
// SDKPoint
    #define SDKPoint                CGPoint
    #define FLPointFromString       CGPointFromString
    #define FLStringFromPoint       NSStringFromCGPoint
    #define FLPointMake             CGPointMake
    #define FLPointEqualToPoint     CGPointEqualToPoint
    #define FLPointsAreEqual        CGPointEqualToPoint
    #define FLPointZero             CGPointZero
    #define FLEmptyPoint            FLPointZero

#else
// NSPoint
    #define SDKPoint                NSPoint
    #define FLPointFromString       NSPointFromString
    #define FLStringFromPoint       NSStringFromPoint
    #define FLPointMake             NSMakePoint
#endif
