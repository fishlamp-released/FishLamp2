//
//  FLARCMacros.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if FL_ARC
#define FLAutorelease(__v) 
#define FLReturnAutoreleased(__v)   __v
#define FLReturnRetained(__v)       __v
#define FLRetain(__v) 
#define FLRelease(__v) 
#define FLSuperDealloc()
#define FLReleaseBlockWithNil(b)    b = nil
#define FLReleaseWithNil(b)         b = nil
#define FLAssignObject(a,b)         a = b
#define FLCopyObject(a,b)           a = [b copy]
#define FLCopyBlock(__BLOCK__)      [__BLOCK__ copy]

NS_INLINE
void FLManuallyRelease(id* obj) {
    if(obj && *obj) {
        CFRelease((__bridge_retained CFTypeRef) (*obj));
        *obj = nil;
    }
}

#define FLBridge(__TO_TYPE__, __FROM_REFERENCE__) \
            ((__bridge __TO_TYPE__) __FROM_REFERENCE__)
            
#define FLBridgeTransfer(__TO_TYPE__, __FROM_REFERENCE__) \
            ((__bridge_transfer __TO_TYPE__) __FROM_REFERENCE__)

#define FLBridgeRetain(__TO_TYPE__, __FROM_REFERENCE__) \
            ((__bridge_retained __TO_TYPE__) __FROM_REFERENCE__)

#define FLBridgeTransferAutoreleased(__TO_TYPE__, __FROM_REFERENCE__) \
            FLBridgeTransfer(__CAST_TO, __FROM_REFERENCE__)

#define FLBridgeObject(__FROM_REFERENCE__) \
            FLBridgeTransferAutoreleased(id, __FROM_REFERENCE__)



#endif