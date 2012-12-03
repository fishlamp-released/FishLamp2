//
//  FLARCMacros.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if FL_ARC

#define mrc_autorelease_(__OBJ__)    
#define mrc_retain_(__OBJ__) 

#define retain_(__OBJ__)                        __OBJ__
#define release_(__OBJ__) 
#define autorelease_(__OBJ__)                   __OBJ__
#define super_dealloc_()

#define bridge_(__TO__, __FROM__)               ((__bridge __TO__) __FROM__)
#define bridge_transfer_(__TO__, __FROM__)      ((__bridge_transfer __TO__) __FROM__)
#define bridge_retain_(__TO__, __FROM__)        ((__bridge_retained __TO__) __FROM__)

// arc utils
#define FLReleaseBlockWithNil_(b)               b = nil
#define FLReleaseWithNil_(b)                    b = nil
#define FLRetainObject_(a,b)                    a = b
#define FLCopyObject_(a,b)                      a = [b copy]
#define FLCopyBlock(__BLOCK__)                  [__BLOCK__ copy]

NS_INLINE
void FLManuallyRelease(id* obj) {
    if(obj && *obj) {
        CFRelease((__bridge_retained CFTypeRef) (*obj));
        *obj = nil;
    }
}

#endif


