
//
//  FLUICompatibility.h
//  FLCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLCore.h"
#import "FLCocoa.h"
#import "FLCocoaRequired.h"

#if IOS
    
    #define FLRgbColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

    #define FLReturnRGBColor(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
        FLReturnStaticObject([UIColor colorWithRed:__RED__/255.0f green:__GREEN__/255.0f blue:__BLUE__/255.0f alpha:__ALPHA__ ])

    #define FLReturnColor(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
        FLReturnStaticObject([UIColor colorWithRed:__RED__ green:__GREEN__ blue:__BLUE__ alpha:__ALPHA__ ] )

#endif

#if OSX
    #define UIView                      NSView
    #define UIViewController            NSViewController
    #define UIImage                     NSImage
    #define UIImageView                 NSImageView
    #define UILabel                     NSTextField
    
    #define FLRgbColor(r,g,b,a) \
        [NSColor colorWithDeviceRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

    #define FLReturnRGBColor(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
        FLReturnStaticObject([NSColor colorWithDeviceRed:__RED__/255.0f green:__GREEN__/255.0f blue:__BLUE__/255.0f alpha:__ALPHA__ ] )

    #define FLReturnColor(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
        FLReturnStaticObject([NSColor colorWithDeviceRed:__RED__ green:__GREEN__ blue:__BLUE__ alpha:__ALPHA__ ] )

    #define UIGraphicsGetCurrentContext() [[NSGraphicsContext currentContext] graphicsPort]

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


#import "NSViewController+FLCompatibility.h"
#import "NSView+FLCompatibility.h"
#import "NSObject+FLTheme.h"

#endif

