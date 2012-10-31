//
//  FLARCMacros.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if FL_MRC

NS_INLINE
void _FLAssignObject(id* a, id b)
{
    if(a && (*a != b)) 
    { 
        [*a release]; 
        *a = [b retain]; 
    }
}
NS_INLINE
void _FLCopyObject(id* a, id b)
{
    if(a && (*a != b)) 
    { 
        [*a release]; 
        *a = [b copy]; 
    }
}
//    NS_INLINE
//    void FLManuallyRelease(id* p)
//    {
//        if(p && *p) {
//        // this generates clang warning but this is correct, maybe there's a way to craft the code or a pragma to get rid of the warning
//            [*p release];
//            *p = nil;
//        }
//    }

#define FLRetain(__v)               [__v retain]
#define FLReturnRetained(__v)       [__v retain]
#define FLRelease(__v)              [__v release]
#define FLReturnAutoreleased(__v)   [__v autorelease]
#define FLAutorelease(__v)          [__v autorelease]
#define FLSuperDealloc()            [super dealloc]
#define FLCopyBlock(__BLOCK__)      FLReturnAutoreleased([__BLOCK__ copy])

NS_INLINE
void FLManuallyRelease(id* obj) {
    if(obj && *obj) {
        [*obj release];
        *obj = nil;
    }
}
typedef void (^__BLOCK)() ;
NS_INLINE
void _FLReleaseBlockWithNil(__BLOCK* block) {
    if(block && *block) {
        [*block release];
        *block = nil;
    }
}

#define FLReleaseWithNil(__OBJ__)   FLManuallyRelease(&(__OBJ__))

#define FLReleaseBlockWithNil(b)    _FLReleaseBlockWithNil((__BLOCK*) &(b))

#define FLAssignObject(a,b)         _FLAssignObject((id*) &a, (id) b)
#define FLCopyObject(a,b)           _FLCopyObject((id*) &a, (id) b)

#define FLBridge(__TO_TYPE__, __FROM_REFERENCE__) \
            ((__TO_TYPE__) __FROM_REFERENCE__)
            
#define FLBridgeTransfer(__TO_TYPE__, __FROM_REFERENCE__) \
            [((__TO_TYPE__) __FROM_REFERENCE__) retain]

#define FLBridgeRetain(__TO_TYPE__, __FROM_REFERENCE__) \
            ((__TO_TYPE__) [__FROM_REFERENCE__ retain])

#define FLBridgeTransferAutoreleased(__TO_TYPE__, __FROM_REFERENCE__) \
            [[((__TO_TYPE__) __FROM_REFERENCE__) retain] autorelease]

#define FLBridgeObject(__FROM_REFERENCE__) \
            [[((id) __FROM_REFERENCE__) retain] autorelease]



#endif