//
//  FLBlocks.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

NS_INLINE
id FLReturnObject(id (^createBlock)(void)) {
    return createBlock != nil ? createBlock() : nil;
}

typedef void (^FLEventCallback)();
typedef void (^FLObjectBlock)(id object);

typedef void (^FLGenericBlock)();


extern void FLPerformBlockInAutoreleasePool(void (^callback)());

extern id FLCopyOrRetainObject(id src);

extern float FLTimeBlock (FLEventCallback block);

typedef void (^FLErrorCallback)(NSError* error);

