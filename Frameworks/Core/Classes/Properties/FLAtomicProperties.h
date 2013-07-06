//
//  FLAtomicProperties.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"
#import "FLAtomic.h"

#define FLSythesizeAtomicInt32Getter(__GETTER__, __PROPERTY_TYPE__, __MEMBER_NAME__) \
    - (__PROPERTY_TYPE__) __GETTER__ { \
        return (__PROPERTY_TYPE__) FLAtomicGet32((int32_t*) &(__MEMBER_NAME__)); \
        } 

#define FLSythesizeAtomicInt32Setter(__SETTER__, __PROPERTY_TYPE__, __MEMBER_NAME__) \
    - (void) __SETTER__:(__PROPERTY_TYPE__) value { \
        FLAtomicSet32((int32_t*) &(__MEMBER_NAME__), (int32_t)value); \
        }

#define FLSythesizeAtomicInt32Property(__GETTER__, __SETTER__, __PROPERTY_TYPE__, __MEMBER_NAME__) \
    FLSythesizeAtomicInt32Getter(__GETTER__, __PROPERTY_TYPE__, __MEMBER_NAME__) \
    FLSythesizeAtomicInt32Setter(__SETTER__, __PROPERTY_TYPE__, __MEMBER_NAME__)
    
    
extern id FLAtomicPropertyGet(id __strong * addr);
extern void FLAtomicPropertySet(id __strong * addr, id newValue, dispatch_block_t setter);
extern void FLAtomicPropertyCopy(id __strong * addr, id newValue, dispatch_block_t setter);

//- (NSString *) name {
//    return FLAtomicGetPropertyValue(&_name);
//}
//- (void)setName:(NSString *) name {
//    FLAtomicSetPropertyValue(&_name, name, NO);
//}

typedef id (^FLAtomicCreateBlock)();

extern void FLAtomicCreateIfNil(id __strong* addr, Class type);
extern void FLAtomicCreateIfNilWithBlock(id __strong* addr, FLAtomicCreateBlock block);

#if 0
#define FLSynthesizeLazyGetterWithInit(__PROPERTY_NAME__, __PROPERTY_TYPE__, __IVAR_NAME__, ... ) \
    - (__PROPERTY_TYPE__) __PROPERTY_NAME__ { \
            if ( __IVAR_NAME__ == nil ) { \
                id var = __VA_ARGS__; \
                if ( OSAtomicCompareAndSwapPtrBarrier(nil, var, (__bridge_retained void*) __IVAR_NAME__) == false ) { \
                    FLRelease(var); /* already set by another thread, so release this one */ \
                } \
            } \
        return __IVAR_NAME__; \
    }
#endif

#define FLSynthesizeLazyGetter(__PROPERTY_NAME__, __PROPERTY_TYPE__, __IVAR_NAME__, __IVAR_TYPE__) \
            - (__PROPERTY_TYPE__) __PROPERTY_NAME__ { \
                if ( __IVAR_NAME__ == nil ) { \
                    FLAtomicCreateIfNil(&__IVAR_NAME__, [__IVAR_TYPE__ class]); \
                } \
                return __IVAR_NAME__; \
            }

#define FLSynthesizeLazyGetterWithBlock(__PROPERTY_NAME__, __PROPERTY_TYPE__, __IVAR_NAME__, __BLOCK__) \
            - (__PROPERTY_TYPE__) __PROPERTY_NAME__ { \
                if ( __IVAR_NAME__ == nil ) { \
                    FLAtomicCreateIfNilWithBlock(&__IVAR_NAME__, __BLOCK__); \
                } \
                return __IVAR_NAME__; \
            }


#define FLSynthesizeLazyGetterDeprecated(__PROPERTY_NAME__, __PROPERTY_TYPE__, __IVAR_NAME__) \
            FLSynthesizeLazyGetter(__PROPERTY_NAME__, __PROPERTY_TYPE__*, __IVAR_NAME__, __PROPERTY_TYPE__)
