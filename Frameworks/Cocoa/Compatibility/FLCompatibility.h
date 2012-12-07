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
#import "FLGeometryCompatibility.h"
#import "FLUICompatibility.h"
#import "FLDeviceCompatibility.h"

// sdk categories
#import "NSValue+FLCompatibility.h"

#if IOS
#define NSEvent UIEvent
#endif