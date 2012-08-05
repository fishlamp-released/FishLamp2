
#import <Foundation/Foundation.h>
#import "FishLampCore.h"

// These are macros that define CocoaX for compatibility between iOS and Mac
// for some common actions. Note that more specific code will still need to 
// be conditionally compiled. This is just for the more common cases and 
// for compatibility with utility functions - like in FLRect.h

#if IOS
// Views
    #define CocoaView                   UIView
    #define CocoaViewController         UIViewController

// Misc
    #define CocoaImage                  UIImage
    #define CocoaColor                  UIColor

#else

// Views
    #define CocoaView                   NSView
    #define CocoaViewController         NSViewController

// Misc
    #define CocoaImage                  NSImage
    #define CocoaColor                  NSColor


// TODO: MOVE THIS
// use our own enum I guess. Not finding equivelent in AppKit
enum {
    UIControlStateNormal       = 0,                       
    UIControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
    UIControlStateDisabled     = 1 << 1,
    UIControlStateSelected     = 1 << 2,                  // flag usable by app (see below)
    UIControlStateApplication  = 0x00FF0000,              // additional flags available for application use
    UIControlStateReserved     = 0xFF000000               // flags reserved for internal framework use
};
typedef NSUInteger UIControlState;
    
#endif

#import "NSValue+FLCocoaCompatibility.h"
