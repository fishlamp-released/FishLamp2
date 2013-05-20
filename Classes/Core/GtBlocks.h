//
//  GtBlocks.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.


NS_INLINE
id GtReturnObject(id (^createBlock)(void)) {
    return createBlock != nil ? createBlock() : nil;
}

typedef void (^GtEventCallback)();
typedef void (^GtObjectBlock)(id object);

typedef void (^GtGenericBlock)();


extern void GtPerformBlockInAutoreleasePool(void (^callback)());

extern id GtCopyOrRetainObject(id src);

extern float GtTimeBlock (GtEventCallback block);

extern void GtDrainPool(NSAutoreleasePool** pool);

extern void GtDrainPoolAndRethrow(NSAutoreleasePool** pool, NSException* ex);

