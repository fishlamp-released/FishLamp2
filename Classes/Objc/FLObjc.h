//
//  FLObjC.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

#import "FLCoreFlags.h"
#import "FLCompilerWarnings.h"

#if DEBUG
    #define FL_SHIP_ONLY_INLINE 
#else
    #define FL_SHIP_ONLY_INLINE NS_INLINE
#endif

// I like having two defines so you can test either in the positive,
// e.g. #if FL_ARC or #if FL_MRC. Imho this is better than #if !FL_ARC, but either way works.
#undef FL_ARC 
#undef FL_MRC

#if __has_feature(objc_arc)
#define FL_ARC 1
#undef  FL_MRC

#import "FLObjcARC.h"
#else
#define FL_MRC 1
#undef  FL_ARC

#import "FLObjcMRC.h"
#endif

#define FLBridgeToObject(__PTR__) \
            FLBridge(id, __PTR__)

#define FLBridgeToPointer(__OBJ__) \
            FLBridge(void*, __PTR__)


@interface NSObject (FLCreateInstance)
+ (id) create;
@end



