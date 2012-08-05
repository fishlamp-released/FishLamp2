//
//	FLAsserts.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"
#import "FLExceptions.h"
#import "FLErrors.h"
#import "FLStringUtils.h"

#ifndef FIXME_WARNINGS
#define FIXME_WARNINGS 1
#endif

#if FIXME_WARNINGS
#define FIXME_PRAGMA(x) _Pragma (#x)
#else
#define FIXME_PRAGMA(x)
#endif

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

#ifndef ASSERTIONS
#define ASSERTIONS 1
#endif

#ifndef USE_NS_ASSERTIONS
#define USE_NS_ASSERTIONS 1
#endif

#if ASSERTIONS

#if USE_NS_ASSERTIONS

	#define FLAssert    NSAssert

	#define FLCAssert   NSCAssert

#else

	#define FLAssert(__CONDITION__, __FORMAT__, ...) \
        if(!(__CONDITION__)) \
            FLThrowErrorCode(   FLAssertionFailedErrorDomain, \
                                FLAssertionFailedErrorCode, \
                                @"ASSERT FAILED: %s (%@) [%@ %@ (%d:%s)]", \
                                #__CONDITION__, \
                                (FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)), \
                                NSStringFromClass([self class]),  \
                                NSStringFromSelector(_cmd), \
                                __LINE__, \
                                __FILE__)

	#define FLCAssert(__CONDITION__, __FORMAT__, ...) \
        if(!(__CONDITION__)) \
            FLThrowErrorCode(   FLAssertionFailedErrorDomain, \
                                FLAssertionFailedErrorCode, \
                                @"ASSERT FAILED: %s (%@) [%d:%s]", \
                                #__CONDITION__, \
                                (FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)), \
                                __LINE__, \
                                __FILE__)

#endif
			
    #define FLAssertIsNotNil(__POINTER__) \
        FLAssert((__POINTER__) != nil, @"'%s' is unexepectedly nil", #__POINTER__)

    #define FLCAssertIsNotNil(__POINTER__) \
        FLCAssert((__POINTER__) != nil, @"'%s' is unexepectedly nil", #__POINTER__)

    #define FLAssertIsNil(__POINTER__) \
        FLAssert((__POINTER__) == nil, @"'%s' is unexepectedly not nil", #__POINTER__)

    #define FLCAssertIsNil(__POINTER__) \
        FLCAssert((__POINTER__) == nil, @"'%s' is unexepectedly not nil", #__POINTER__)

    #define FLAssertStringIsNotEmpty(__STRING__) \
        FLAssert(FLStringIsNotEmpty(__STRING__), @"unexepectedly empty string: %s", #__STRING__)
        
    #define FLCAssertStringIsNotEmpty(__STRING__) \
        FLCAssert(FLStringIsNotEmpty(__STRING__), @"unexepectedly empty string: %s", #__STRING__)
        
	#define FLAssertFailed(__FORMAT__, ...) \
        FLAssert(NO, __FORMAT__,  ##__VA_ARGS__)

	#define FLCAssertFailed(__FORMAT__, ...) \
        FLCAssert(NO, __FORMAT__,  ##__VA_ARGS__)

	#define FLAssertDefaultInitNotCalled() \
		- (id) init { \
            FLAssertFailed(@"default init should not be called here"); \
            return self; \
        }
		      
	#define FLRequiredOverride() \
        FLAssertFailed(@"Required Override")
    
    #define FLNotImplemented(__STR__, ...) \
        FLAssertFailed(@"Not implemented: %@", __STR__, ##__VA_ARGS__)

    #define FLCNotImplemented(__STR__, ...) \
        FLCAssertFailed(@"Not implemented: %@", __STR__, ##__VA_ARGS__)

    #define FLFixMe(__STR__) \
        FIXME_PRAGMA(message("FIXME: " #__STR__)); \
        FLAssertFailed(@"FIXME: %@", __STR__) 

    #define FLCFixMe(__STR__) \
        FIXME_PRAGMA(message("FIXME: " #__STR__)); \
        FLCAssertFailed(@"FIXME: %@", __STR__)
        
	#define FLAssertIsType(__OBJ__, __TYPE__) \
		FLAssert(   [__OBJ__ isKindOfClass:[__TYPE__ class]], \
                    @"Expecting class __TYPE__: %@ but got %@", \
                    NSStringFromClass([__OBJ__ class]), \
                    NSStringFromClass([__TYPE__ class]))

	#define FLCAssertIsType(__OBJ__, __TYPE__) \
		FLCAssert(   [__OBJ__ isKindOfClass:[__TYPE__ class]], \
                    @"Expecting class __TYPE__: %@ but got %@", \
                    NSStringFromClass([__OBJ__ class]), \
                    NSStringFromClass([__TYPE__ class]))

#else

    #define FLAssert(__CONDITION__, __FORMAT__, ...)

    #define FLCAssert(__CONDITION__, __FORMAT__, ...)

    #define FLAssertIsNotNil(__POINTER__) 

    #define FLCAssertIsNotNil(__POINTER__)

    #define FLAssertIsNil(__POINTER__)

    #define FLCAssertIsNil(__POINTER__)

    #define FLAssertStringIsNotEmpty(__STRING__)
        
    #define FLCAssertStringIsNotEmpty(__STRING__)
        
	#define FLAssertFailed(__FORMAT__, ...)

	#define FLCAssertFailed(__FORMAT__, ...)

	#define FLAssertDefaultInitNotCalled()
		      
	#define FLRequiredOverride()
    
    #define FLNotImplemented(__STR__, ...)

    #define FLCNotImplemented(__STR__, ...)

    #define FLFixMe(__STR__)

    #define FLCFixMe(__STR__)
        
	#define FLAssertIsType(__OBJ__, __TYPE__)

	#define FLCAssertIsType(__OBJ__, __TYPE__)

#endif

        
//#define FLAssertIsNil FLAssertIsNil
//#define FLAssertIsNotNil FLAssertIsNotNil

