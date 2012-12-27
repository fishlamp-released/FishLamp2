//
//  FLARCMacros.m
//  FLCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if FL_MRC

#import <objc/runtime.h>

// object memory management
#define FLRetain(__OBJ__)   \
            [__OBJ__ retain]

NS_INLINE
void FLRetainObject(id object) {
    [object retain];
}

#define FLRelease(__OBJ__) \
            [__OBJ__ release]

#define FLAutorelease(__OBJ__) \
            [__OBJ__ autorelease] 

NS_INLINE
void FLAutoreleaseObject(id object) {
    [object autorelease];
}

#define FLSuperDealloc() \
            [super dealloc]
    //#define super_dealloc_()                    [self performSelector:sel_getUid("sendDeallocNotification")]; [super dealloc]
            
#define bridge_(__TO__, __FROM__) \
            ((__TO__) __FROM__)

#define bridge_transfer_(__TO__, __FROM__) \
            ((__TO__) __FROM__)

#define bridge_FLRetain(__TO__, __FROM__) \
            ((__TO__) [__FROM__ retain])

// mrc utils

NS_INLINE
void FLManuallyRelease(id* obj) {
    if(obj && *obj) {
        [*obj release];
        *obj = nil;
    }
}

NS_INLINE
void _FLRetainObject(id* a, id b) {
    if(a && (*a != b)) { 
        [*a release]; 
        *a = [b retain]; 
    }
}

NS_INLINE
void _FLAssignObjectWithCopy(id* a, id b) {
    if(a && (*a != b)) { 
        [*a release]; 
        *a = [b copy]; 
    }
}

NS_INLINE
void _FLReleaseBlockWithNil_(dispatch_block_t* block) {
    if(block && *block) {
        [*block release];
        *block = nil;
    }
}

#define FLReleaseWithNil(__OBJ__) \
            FLManuallyRelease(&(__OBJ__))

#define FLReleaseBlockWithNil(b) \
            _FLReleaseBlockWithNil_((dispatch_block_t*) &(b))

#define FLSetObjectWithRetain(a,b) \
            _FLRetainObject((id*) &a, (id) b)

#define FLSetObjectWithCopy(a,b) \
            _FLAssignObjectWithCopy((id*) &a, (id) b)

#define FLAutoreleasedCopy(__OBJECT__) \
            FLAutorelease([__OBJECT__ copy])

#define FLAutoreleasedMutableCopy(__OBJECT__) \
            FLAutorelease([__OBJECT__ mutableCopy])

#define FLAutoreleasedRetained(__OBJECT__) \
            FLAutorelease([__OBJECT__ retain])

#define FLAutoreleasePoolOpen(__NAME__) \
    { \
        NSAutoreleasePool* __NAME__ = [[NSAutoreleasePool alloc] init]; \
        @try {

#define FLAutoreleasePoolClose(__NAME__) \
            [__NAME__ drain]; \
        } \
        @catch(id exception) { \
            [exception retain]; \
            [__NAME__ drain]; \
            [exception autorelease]; \
            @throw; \
        } \
    }

#define FLAutoreleasePoolWithName(__NAME__, __VA_ARGS__) \
            FLAutoreleasePoolOpen(__NAME__) \
            __VA_ARGS__ \
            FLAutoreleasePoolClose(__NAME__) \
    

#endif