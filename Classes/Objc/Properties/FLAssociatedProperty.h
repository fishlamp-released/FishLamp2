//
//  FLAssociatedProperty.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// prettier and shorter versions of ugly association policy
enum {
    assign_nonatomic    = OBJC_ASSOCIATION_ASSIGN,
    retain_nonatomic    = OBJC_ASSOCIATION_RETAIN_NONATOMIC,
    retain_atomic       = OBJC_ASSOCIATION_RETAIN,
    copy_nonatomic      = OBJC_ASSOCIATION_COPY_NONATOMIC,
    copy_atomic         = OBJC_ASSOCIATION_COPY
};

#define FLSynthesizeAssociatedProperty(__ASSOCIATION_POLICY__, __GETTER_NAME__, __SETTER_NAME__, __OBJECT_TYPE__) \
    static void * const s_##__GETTER_NAME__##PropertyKey = (void*)&s_##__GETTER_NAME__##PropertyKey; \
    - (void) __SETTER_NAME__:(__OBJECT_TYPE__) obj { \
        objc_setAssociatedObject(self, s_##__GETTER_NAME__##PropertyKey, obj, __ASSOCIATION_POLICY__); \
    } \
    - (__OBJECT_TYPE__) __GETTER_NAME__ { \
        return (__OBJECT_TYPE__) objc_getAssociatedObject(self, s_##__GETTER_NAME__##PropertyKey); \
    }

