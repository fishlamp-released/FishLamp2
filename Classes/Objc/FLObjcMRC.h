//
//  FLARCMacros.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if !__has_feature(objc_arc)
#define FL_MRC 1

// object memory management
#define retain_(__OBJ__)                    [__OBJ__ retain]
#define mrc_retain_(__OBJ__)                [__OBJ__ retain]
#define autorelease_(__OBJ__)               [__OBJ__ autorelease]
#define mrc_autorelease_(__OBJ__)           [__OBJ__ autorelease]
#define release_(__OBJ__)               [__OBJ__ release]
#define mrc_super_dealloc_()                [super dealloc]
#define bridge_(__TO__, __FROM__)           ((__TO__) __FROM__)
#define bridge_transfer_(__TO__, __FROM__)  [((__TO__) __FROM__) retain]
#define bridge_retain_(__TO__, __FROM__)    ((__TO__) [__FROM__ retain])

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
void _FLCopyObject(id* a, id b) {
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

#define FLReleaseWithNil_(__OBJ__)      FLManuallyRelease(&(__OBJ__))
#define FLReleaseBlockWithNil_(b)       _FLReleaseBlockWithNil_((dispatch_block_t*) &(b))
#define FLRetainObject_(a,b)            _FLRetainObject((id*) &a, (id) b)
#define FLCopyObject_(a,b)              _FLCopyObject((id*) &a, (id) b)
#define FLCopyBlock(__BLOCK__)          autorelease_([__BLOCK__ copy])



#endif