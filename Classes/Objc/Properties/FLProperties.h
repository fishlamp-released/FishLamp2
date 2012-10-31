//
//	FLProperties.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLObjc.h"
#import "FLDebug.h"
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

#define lazycreate strong

#define FLSynthesizeDictionaryProperty(__GETTER__, __SETTER__, __TYPE__, __KEY__, __DICTIONARY__) \
    - (__TYPE__) __GETTER__ { \
        return [__DICTIONARY__ objectForKey:__KEY__]; \
    } \
    - (void) __SETTER__:(__TYPE__) object { \
        if(object) [__DICTIONARY__ setObject:object forKey:__KEY__]; \
        else [__DICTIONARY__ removeObjectForKey:__KEY__]; \
    }
