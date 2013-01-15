//
//	FLProperties.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FLRequired.h"
#import "FLSingletonProperty.h"
#import "FLAssociatedProperty.h"
#import "FLAtomicProperties.h"
#import "FLStructFlagsProperty.h"
#import "FLStaticMemberProperty.h"
#import "FLDefaultProperty.h"
#import "FLBitFlagsProperty.h"

#define FLSynthesizeLazyCreateGetterWithInit(__NAME__, __TYPE__, /*[[type alloc] init]*/ ...) \
    - (__TYPE__*) __NAME__ { \
            if ( _##__NAME__ == nil ) { \
                id var = __VA_ARGS__; \
                if ( OSAtomicCompareAndSwapPtrBarrier(nil, var, bridge_(void*, &_##__NAME__)) == false ) { \
                    FLRelease(var); /* already set by another thread, so release this one */ \
                } \
            } \
        return _##__NAME__; \
    }

#define FLSynthesizeLazyCreateGetter(__NAME__, __TYPE__) \
            FLSynthesizeLazyCreateGetterWithInit(__NAME__, __TYPE__, [[__TYPE alloc] init])

#define FLSynthesizeDictionaryProperty(__GETTER__, __SETTER__, __TYPE__, __KEY__, __DICTIONARY__) \
    - (__TYPE__) __GETTER__ { \
        return [__DICTIONARY__ objectForKey:__KEY__]; \
    } \
    - (void) __SETTER__:(__TYPE__) object { \
        if(object) [__DICTIONARY__ setObject:object forKey:__KEY__]; \
        else [__DICTIONARY__ removeObjectForKey:__KEY__]; \
    }

//#define FLSynthesizeLazyGetterCustom(__NAME__, __MEMBER__, __TYPE__, ...) \
//    - (__TYPE__*) __NAME__ { \
//        static dispatch_once_t s_pred = 0; \
//        dispatch_once(&s_pred, ^{ if(!__MEMBER__) __MEMBER__ = __VA_ARGS__; }); \
//        return __MEMBER__; \
//    } 
//
//#define FLSynthesizeLazyGetter(__NAME__, __TYPE__) \
//            FLSynthesizeLazyGetterCustom(__NAME__, _##__NAME__, __TYPE__, [[__TYPE__ alloc] init])




