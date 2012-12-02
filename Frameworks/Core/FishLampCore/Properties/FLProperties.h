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

#define FLSynthesizeLazyCreateGetter(__NAME__, __TYPE__) \
    - (__TYPE__*) __NAME__ { \
        if(!_##__NAME__) { \
            _##__NAME__ = [[__TYPE__ alloc] init]; \
        } \
        return _##__NAME__; \
    }

#define FLSynthesizeLazyCreateGetterAtomic(__NAME__, __TYPE__) \
    - (__TYPE__*) __NAME__ { \
            if ( _##__NAME__ == nil ) { \
                id var = [[__TYPE__ alloc] init]; \
                if ( OSAtomicCompareAndSwapPtrBarrier(nil, var, &_##__NAME__) == false ) \
                    [var release]; /* already set by another thread, so release this one */ \
            } \
        return _##__NAME__; \
    }


#define lazycreate strong

#define FLSynthesizeDictionaryProperty(__GETTER__, __SETTER__, __TYPE__, __KEY__, __DICTIONARY__) \
    - (__TYPE__) __GETTER__ { \
        return [__DICTIONARY__ objectForKey:__KEY__]; \
    } \
    - (void) __SETTER__:(__TYPE__) object { \
        if(object) [__DICTIONARY__ setObject:object forKey:__KEY__]; \
        else [__DICTIONARY__ removeObjectForKey:__KEY__]; \
    }

#define synthesize_(__NAME__) @synthesize __NAME__ = _##__NAME__;

//#define synthesize_lazy_atomic_(__NAME__, __TYPE__) @synthesize __NAME__ = _##__NAME__; \
//                                                FLSynthesizeLazyCreateGetter(__NAME__, __TYPE__)
                                                
                                                
                                                
                                                
//                                                + (id) someStaticValueComputedOnFirstAccess
//{
//    static volatile id __staticVar = nil;
//    if ( __staticVar == nil )
//    {
//        id var = [[Something alloc] init];
//        if ( OSAtomicCompareAndSwapPtrBarrier(nil, var, &__staticVar) == false )
//            [var release];  // already set by another thread, so release this one
//    }
//    
//    return ( __staticVar );
//}

