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

// I like having two defines so you can test either in the positive,
// e.g. #if FL_ARC or #if FL_MRC. Imho this is better than #if !FL_ARC, but either way works.
#undef FL_ARC 
#undef FL_MRC

#import "FLCoreFlags.h"
#import "FLCompilerWarnings.h"
#import "FLObjcARC.h"
#import "FLObjcMRC.h"
#import "FLDebug.h"

// prob doesn't belong here.
#import "FLCoreFoundation.h"

// experimental
@interface NSObject (FLCreateInstance)
+ (id) create;
@end

