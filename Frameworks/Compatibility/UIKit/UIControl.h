//
//  UIControl.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "UIKitRequired.h"

#if OSX

#define UIControl NSControl

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
