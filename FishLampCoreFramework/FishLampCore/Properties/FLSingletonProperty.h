//
//  FLSingleton.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

/// FLSingletonProperty is a macro for defining a singleton object.
/// @param __class The type of the class (for example MyClass). 
#define FLSingletonProperty(__class) + (__class*)instance; \
                                     + (void) createInstance; \
                                     + (void) releaseInstance;

/// Synthesizes all the boilerplate for declaring a thread safe fast singleton
#define FLSynthesizeSingleton(__class) \
    static dispatch_once_t s_pred1##__class = 0; \
    static dispatch_once_t s_pred2##__class = 0; \
    static __class* s_instance##__class = nil; \
    + (__class*) instance { \
        dispatch_once(&s_pred1##__class, ^{ s_instance##__class = [[[self class] alloc] init]; s_pred2##__class = 0; }); \
        return s_instance##__class; \
        } \
	+ (void) createInstance { \
        [self instance]; \
    }   \
    + (void) releaseInstance { \
        dispatch_once(&s_pred2##__class, ^{ FLReleaseWithNil_(s_instance##__class); s_pred1##__class = 0; }); \
        }

#define singleton_property_ FLSingletonProperty
#define synthesize_singleton_ FLSynthesizeSingleton

#define _use_macro_(__NAME__) FIXME(please use macro #__NAME__)

#define singleton_property      _use_macro_(singleton_property_)
#define synthesize_singleton    _use_macro_(synthesize_singleton_)

//           \
//    + (id)allocWithZone:(NSZone * const)notUsed { \
//        return [self instance]; \
//    }
