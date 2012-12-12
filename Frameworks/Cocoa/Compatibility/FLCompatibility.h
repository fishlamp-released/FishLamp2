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
    #define SDKEdgeInsets               UIEdgeInsets
    #define SDKEvent                    UIEvent

    #define FLIOS(...)                  __VA_ARGS__
    #define FLOSX(...)
#endif

#if OSX
    #define SDKEdgeInsets               NSEdgeInsets
    #define SDKEvent                    NSEvent

    // TODO - get rid of these
    #define DeviceIsPad()   NO
    #define DeviceIsPhone() NO
    #define DeviceIsPod()   NO
    #define DeviceIsSimulator() NO

    #define FLIOS(...)
    #define FLOSX(...)                  __VA_ARGS__

#endif

// sdk categories
#import "NSValue+FLCompatibility.h"

