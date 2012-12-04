
#import <Foundation/Foundation.h>
#import "FishLampCore.h"

// These are macros that define CocoaX for compatibility between iOS and Mac
// for some common actions. Note that more specific code will still need to 
// be conditionally compiled. This is just for the more common cases and 
// for compatibility with utility functions - like in FLRect.h

#if IOS
#import "FLiOSCompatibility.h"
#else
#import "FLOSXCompatibility.h"
#endif

#import "NSValue+FLCocoaCompatibility.h"
#import "FLGeometry.h"

