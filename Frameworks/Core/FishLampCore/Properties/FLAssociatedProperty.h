//
//  FLAssociatedProperty.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

#import <objc/runtime.h>

// prettier and shorter versions of ugly association policy
#define    assign_nonatomic    OBJC_ASSOCIATION_ASSIGN
#define    retain_nonatomic    OBJC_ASSOCIATION_RETAIN_NONATOMIC
#define    retain_atomic       OBJC_ASSOCIATION_RETAIN
#define    copy_nonatomic      OBJC_ASSOCIATION_COPY_NONATOMIC
#define    copy_atomic         OBJC_ASSOCIATION_COPY

#define FLSynthesizeAssociatedObjectKey_(__NAME__) \
            static void * const __NAME__ = (void*)&__NAME__ 

#define __KEYNAME__(__NAME__) s_##__NAME__##Key

#define FLSynthesizeAssociatedProperty_(__ASSOCIATION_POLICY__, __GETTER__, __SETTER__, __TYPE__) \
    FLSynthesizeAssociatedObjectKey_(__KEYNAME__(__GETTER__)); \
    \
    - (void) __SETTER__:(__TYPE__) obj { \
        objc_setAssociatedObject(self, __KEYNAME__(__GETTER__), obj, __ASSOCIATION_POLICY__); \
    } \
    - (__TYPE__) __GETTER__ { \
        return (__TYPE__) objc_getAssociatedObject(self, __KEYNAME__(__GETTER__)); \
    }

#define FLSynthesizeAssociatedPropertyWithLazyGetter_(__ASSOCIATION_POLICY__, __GETTER__, __SETTER__, __TYPE__, __CREATER__) \
    FLSynthesizeAssociatedObjectKey_(__KEYNAME__(__GETTER__)); \
    - (void) __SETTER__:(__TYPE__) obj { \
        objc_setAssociatedObject(self, __KEYNAME__(__GETTER__), obj, __ASSOCIATION_POLICY__); \
    } \
    - (__TYPE__) __GETTER__ { \
        __TYPE__ obj = (__TYPE__) objc_getAssociatedObject(self, __KEYNAME__(__GETTER__)); \
        if(!obj) { \
            @synchronized(self) { \
                obj = (__TYPE__) objc_getAssociatedObject(self, __KEYNAME__(__GETTER__)); \
                if(!obj) { \
                    obj = __CREATER__; \
                    objc_setAssociatedObject(self, __KEYNAME__(__GETTER__), obj, __ASSOCIATION_POLICY__); \
                } \
            } \
        } \
        return obj; \
    }
