//
//  SDKCompatibility.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

// These are macros that define CocoaX for compatibility between iOS and Mac
// for some common actions. Note that more specific code will still need to 
// be conditionally compiled. This is just for the more common cases and 
// for compatibility with utility functions - like in SDKRectUtilities.h

#import "FishLampCore.h"
#import "SDKValue.h"
#import "SDKPoint.h"
#import "SDKSize.h"
#import "SDKRect.h"
#import "SDKImage.h"
#import "SDKEdgeInsets.h"
#import "SDKColor.h"

// TODO: refactor these out

#if IOS
#define SDKView                     UIView
#define SDKViewController           UIViewController
#endif

#if OSX
#define SDKView                     NSView
#define SDKViewController           NSViewController

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
    
// TODO - get rid of these
#define DeviceIsPad()   NO
#define DeviceIsPhone() NO
#define DeviceIsPod()   NO
#define DeviceIsSimulator() NO
 
#endif