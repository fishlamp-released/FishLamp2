//
// UIKitModule.h
// FishLamp
//
// Module: UIKitModule
// Module Meta Data: file://UIKitModule.json
// Note: This is a generated file. Modifications will be overwritten.
//
// Created by Mike Fullerton on Thu Dec 13 13:34:22 HST 2012
// Copyright (c) 2012 GreenTongue Software LLC. All Rights Reserved.
//
#if OSX
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AppKit/AppKit.h>

#import "FishLampCore.h"
#import "FLCompatibleGeometry+OSX.h"

#import "NSValue+FLCompatibility.h"
#import "NSColor+FLCompatibility.h"
#import "NSControl+FLCompatibility.h"
#import "NSDevice+FLCompatibility.h"
#import "NSImage+FLCompatibility.h"
#import "NSTextField+FLCompatibility.h"
#import "NSView+FLCompatibility.h"

#import "FLCompatibleView+OSX.h"
#import "FLCompatibleViewController+OSX.h"


#define UIGraphicsGetCurrentContext() [[NSGraphicsContext currentContext] graphicsPort]

#endif