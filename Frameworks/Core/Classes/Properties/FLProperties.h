//
//	FLProperties.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/28/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FLRequired.h"
#import "FLSingletonProperty.h"
#import "FLAssociatedProperty.h"
#import "FLAtomicProperties.h"
#import "FLStructFlagsProperty.h"
#import "FLStaticMemberProperty.h"
#import "FLDefaultProperty.h"
#import "FLBitFlagsProperty.h"

#define FLSynthesizeLazyCreateGetterWithInit(__NAME__, __TYPE__, __IVAR__, /*[[type alloc] init]*/ ...) \
    - (__TYPE__*) __NAME__ { \
            if ( __IVAR__ == nil ) { \
                id var = __VA_ARGS__; \
                if ( OSAtomicCompareAndSwapPtrBarrier(nil, var, bridge_(void*, &__IVAR__)) == false ) { \
                    FLRelease(var); /* already set by another thread, so release this one */ \
                } \
            } \
        return __IVAR__; \
    }

#define FLSynthesizeLazyGetter(__NAME__, __TYPE__, __IVAR__) \
            FLSynthesizeLazyCreateGetterWithInit(__NAME__, __TYPE__, __IVAR__, [[__TYPE__ alloc] init])

#define FLSynthesizeDictionaryGetterProperty(__GETTER__, __TYPE__, __KEY__, __DICTIONARY__) \
    - (__TYPE__) __GETTER__ { \
        return [__DICTIONARY__ objectForKey:__KEY__]; \
    } 

#define FLSynthesizeDictionaryProperty(__GETTER__, __SETTER__, __TYPE__, __KEY__, __DICTIONARY__) \
    - (__TYPE__) __GETTER__ { \
        return [__DICTIONARY__ objectForKey:__KEY__]; \
    } \
    - (void) __SETTER__:(__TYPE__) object { \
        if(object) [__DICTIONARY__ setObject:object forKey:__KEY__]; \
        else [__DICTIONARY__ removeObjectForKey:__KEY__]; \
    }




