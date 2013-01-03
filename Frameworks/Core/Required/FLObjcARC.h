//
//  FLARCMacros.h
//  FLCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if FL_ARC

#define FLRetain(__OBJ__) \
            __OBJ__

#define FLRetainObject(__OBJ__) 

#define FLRelease(__OBJ__) 

#define FLAutorelease(__OBJ__) \
            __OBJ__

#define FLAutoreleaseObject(__OBJ__)    

#define FLSuperDealloc()

#define bridge_(__TO__, __FROM__) \
            ((__bridge __TO__) __FROM__)
            
#define bridge_transfer_(__TO__, __FROM__) \
            ((__bridge_transfer __TO__) __FROM__)

#define bridge_retain(__TO__, __FROM__) \
            ((__bridge_retained __TO__) __FROM__)

#define FLReleaseBlockWithNil(__BLOCK__) __BLOCK__ = nil

NS_INLINE
void FLManuallyRelease(id* obj) {
    if(obj && *obj) {
        CFRelease((__bridge_retained CFTypeRef) (*obj));
        *obj = nil;
    }
}

#define FLAutoreleasePoolOpen(__NAME__) 

#define FLAutoreleasePoolClose(__NAME__) 

#endif


