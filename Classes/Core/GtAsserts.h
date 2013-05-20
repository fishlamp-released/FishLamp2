//
//	GT_Asserts.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

#import "GtExceptions.h"

#ifndef ASSERTIONS
#define ASSERTIONS DEBUG
#endif

#if ASSERTIONS

	#define GtAssert(__CONDITION__, __FORMAT__, ...) \
        if(!(__CONDITION__)) \
            GtThrowErrorCode(   GtAssertionFailedErrorDomain, \
                                GtAssertionFailedErrorCode, \
                                @"ASSERT FAILED: %s (%@)", \
                                #__CONDITION__, \
                                (GtStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)))
			
    #define GtAssertIsNotNil(__POINTER__) \
        GtAssert((__POINTER__) != nil, @"'%s' is unexepectedly nil", #__POINTER__)
	
    #define GtAssertIsNil(__POINTER__) \
        GtAssert((__POINTER__) == nil, @"'%s' is unexepectedly not nil", #__POINTER__)

    #define GtAssertStringIsNotEmpty(__STRING__) \
        GtAssert(GtStringIsNotEmpty(__STRING__), @"unexepectedly empty string: %s", #__STRING__)

	#define GtThrowAssertionFailure(__FORMAT__, ...) \
        GtAssert(NO, __FORMAT__,  ##__VA_ARGS__)
    
	#define GtAssertDefaultInitNotCalled() \
		- (id) init { \
            GtThrowAssertionFailure(@"default init should not be called here"); \
            return self; \
        }
		
	#define GtThrowRequiredOverrideAssertionFailure() \
        GtThrowAssertionFailure(@"Required Override")
    
    #define GtThrowNotImplementedAssertionFailure() \
        GtThrowAssertionFailure(@"Not implemented")

	#define GtAssertObjectIsOfType(__OBJ__, __TYPE__) \
		GtAssert(   [__OBJ__ isKindOfClass:[__TYPE__ class]], \
                    @"Expecting class __TYPE__: %@ but got %@", \
                    NSStringFromClass([__OBJ__ class]), \
                    NSStringFromClass([__TYPE__ class]))

//    #define GtAssertIsExpectedType(object, type) GtAssert([object isKindOfClass:[type class]])
#else
    #define GtAssertIsExpectedType(__o, __t)

    #define GtAssert(__CONDITION__, __FORMAT__, ...)

	#define GtAssertIsNotNil(__POINTER__)

	#define GtAssertIsNil(__POINTER__)

	#define GtAssertStringIsNotEmpty(__STRING__)

    #define GtThrowNotImplementedAssertionFailure()

	#define GtAssertObjectIsOfType(__OBJ__, __TYPE__)

	#define GtThrowAssertionFailure(__FORMAT__, ...)

	#define GtAssertDefaultInitNotCalled();

	#define GtThrowRequiredOverrideAssertionFailure()

//    #define GtAssertIsExpectedType(object, type)
#endif

#define GtAssertIsExpectedType \
            GtAssertObjectIsOfType

#define GtAssertIsValidString \
            GtAssertStringIsNotEmpty         

#define GtAssertNil \
            GtAssertIsNil

#define GtAssertNotNil \
            GtAssertIsNotNil

#define GtAssertFailed \
            GtThrowAssertionFailure
            
#define GtAssertFailedNotImplemented \
            GtThrowNotImplementedAssertionFailure