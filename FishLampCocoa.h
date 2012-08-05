//
//  FishLamp.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/23/12
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "FishLampCore.h"

#if IOS
    #import <UIKit/UIKit.h>
    #import <CoreGraphics/CoreGraphics.h>
    #import <MobileCoreServices/MobileCoreServices.h>
    #import <ImageIO/ImageIO.h>
#else
    #import <Cocoa/Cocoa.h>
    #import <AppKit/AppKit.h>
    #import <CoreServices/CoreServices.h>
#endif

#import "FLGeometry.h"
#import "FLCocoaCompatibility.h"


#if TEST
#import "FLUnitTest.h"
#endif

#import "FLTracker.h"