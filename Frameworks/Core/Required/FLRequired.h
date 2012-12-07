//
//  FLObjC.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.
#import <Foundation/Foundation.h>

#if DEBUG
    #define FL_SHIP_ONLY_INLINE 
#else
    #define FL_SHIP_ONLY_INLINE NS_INLINE
#endif

#import "FLCoreFlags.h"
#import "FLCompilerWarnings.h"

// We have two defines so you can test either in the positive, e.g. #if FL_ARC or #if FL_MRC. 
// This is more readable than #if !FL_ARC, but either way works.
#undef FL_ARC 
#undef FL_MRC

#if __has_feature(objc_arc)
    #define FL_ARC 1
    #import "FLObjcARC.h"
#else
    #define FL_MRC 1
    #import "FLObjcMRC.h"
#endif

// todo remove these
#define FLReleaseWithNil_                   FLReleaseWithNil 
#define FLReleaseBlockWithNil_              FLReleaseBlockWithNil
#define super_dealloc_                      FLSuperDealloc

#import "FLDebug.h"
#import "FLMath.h"

