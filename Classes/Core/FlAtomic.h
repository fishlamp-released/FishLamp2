//
//  FlAtomicBitFlags.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import <libkern/OSAtomic.h>
#import "_FLAtomic.h"

#define FLAtomicSet64(__MASK__, __VALUE__) \
    FLAtomicSet64_((int64_t*)&(__MASK__), __VALUE__)

#define FLAtomicGet64(__MASK__) \
    FLAtomicGet64_((int64_t*)&(__MASK__))

#define FLAtomicSet32(__MASK__, __VALUE__) \
    FLAtomicSet32_((int32_t*)&(__MASK__), __VALUE__)

#define FLAtomicGet32(__MASK__) \
    FLAtomicGet32_((int32_t*)&(__MASK__))

#define FLAtomicIncrement32(__NUMBER__) \
    OSAtomicIncrement32((int32_t*) &(__NUMBER__))

#define FLAtomicDecrement32(__NUMBER__) \
    OSAtomicDecrement32((int32_t*) &(__NUMBER__))





