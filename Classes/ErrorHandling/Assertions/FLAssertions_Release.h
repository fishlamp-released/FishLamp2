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
#import "FLStringUtils.h"
#import "FLCompilerWarnings.h"
#import "NSException+NSError.h"
#import "FLMutableError.h"
#import "FLAssertionFailureErrorDomain.h"

#define FLAssertionComment FLStringWithFormatOrNil

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

#ifndef ASSERTIONS
#define ASSERTIONS 1
#endif

#if ASSERTIONS
#import "FLAssertions_Internal.h"

#define FLThrowAssertionFailure(__TYPE__, __REASON_OR_NIL__, __COMMENT_OR_NIL__) \
    FLThrowError([FLMutableError errorWithErrorDomain:[FLAssertionFailureErrorDomain instance] \
                            code:(__TYPE__) \
                            userInfo:nil \
                            reason:__REASON_OR_NIL__ \
                            comment:(__COMMENT_OR_NIL__) \
                            stackTrace:FLCreateStackTrace(YES)]) \
                            
                            

#define FLCThrowAssertionFailure(__TYPE__, __REASON_OR_NIL__, __COMMENT_OR_NIL__) \
    FLCThrowError([FLMutableError errorWithErrorDomain:[FLAssertionFailureErrorDomain instance] \
                            code:(__TYPE__) \
                            userInfo:nil \
                            reason:__REASON_OR_NIL__ \
                            comment:(__COMMENT_OR_NIL__) \
                            stackTrace:FLCreateStackTrace(YES)])

// FLAssert(BOOL condition, __COMMENT__, ...)

#define FLConfirm(__CONDITION__) \
            __FLAssert(FLThrowAssertionFailure, __CONDITION__, nil)

#define FLCConfirm(__CONDITION__) \
            __FLAssert(FLCThrowAssertionFailure, __CONDITION__, nil)

#define FLAssert(__CONDITION__, __COMMENT__, ...) \
            __FLAssert(FLThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssert(__CONDITION__, __COMMENT__, ...) \
            __FLAssert(FLCThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))


// FLAssertFailed(__COMMENT__, ...)

#define FLAssertFailed(__COMMENT__, ...) \
            __FLAssertFailed(FLThrowAssertionFailure, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertionFailed(__COMMENT__, ...) \
            __FLAssertFailed(FLCThrowAssertionFailure, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))


// FLAssertNotNil(id pointer, __COMMENT__, ...)

#define FLConfirmIsNotNil(__POINTER__) \
            __FLAssertNotNil(FLThrowAssertionFailure, __POINTER__, nil)

#define FLCConfirmNotNil(__POINTER__) \
            __FLAssertNotNil(FLCThrowAssertionFailure, __POINTER__, nil)

#define FLAssertNotNil(__POINTER__, __COMMENT__, ...) \
            __FLAssertNotNil(FLThrowAssertionFailure, __POINTER__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertNotNil(__POINTER__, __COMMENT__, ...) \
            __FLAssertNotNil(FLCThrowAssertionFailure, __POINTER__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertNil(id point, __COMMENT__, ...)

#define FLConfirmIsNil(__POINTER__) \
            __FLAssertNil(FLThrowAssertionFailure, __POINTER__, nil)

#define FLCConfirmNil(__POINTER__) \
            __FLAssertNil(FLCThrowAssertionFailure, __POINTER__, nil)

#define FLAssertNil(__POINTER__, __COMMENT__, ...) \
            __FLAssertNil(FLThrowAssertionFailure, __POINTER__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertNil(__POINTER__, __COMMENT__, ...) \
            __FLAssertNil(FLCThrowAssertionFailure, __POINTER__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertStringIsNotEmpty(NSString* stringOrNil, __COMMENT__, ...)

#define FLConfirmStringIsNotEmpty(__STRING__) \
            __FLAssertStringIsNotEmpty(FLThrowAssertionFailure, __STRING__, nil)

#define FLCConfirmStringIsNotEmpty(__STRING__) \
            __FLAssertStringIsNotEmpty(FLCThrowAssertionFailure, __STRING__, nil)

#define FLAssertStringIsNotEmpty(__STRING__, __COMMENT__, ...) \
            __FLAssertStringIsNotEmpty(FLThrowAssertionFailure, __STRING__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertStringIsNotEmpty(__STRING__, __COMMENT__, ...) \
            __FLAssertStringIsNotEmpty(FLCThrowAssertionFailure, __STRING__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertTrue(BOOL shouldBeTrue, __COMMENT__, ...)

#define FLConfirmTrue(__CONDITION__) \
            __FLAssertTrue(FLThrowAssertionFailure, __CONDITION__, nil)

#define FLCConfirmTrue(__CONDITION__) \
            __FLAssertTrue(FLCThrowAssertionFailure, __CONDITION__, nil)

#define FLAssertTrue(__CONDITION__, __COMMENT__, ...) \
            __FLAssertTrue(FLThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertTrue(__CONDITION__, __COMMENT__, ...) \
            __FLAssertTrue(FLCThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertFalse(BOOL shouldBeFalse, __COMMENT__, ...)

#define FLConfirmFalse(__CONDITION__) \
            __FLAssertFalse(FLThrowAssertionFailure, __CONDITION__, nil)

#define FLCConfirmFalse(__CONDITION__) \
            __FLAssertFalse(FLCThrowAssertionFailure, __CONDITION__, nil)


#define FLAssertFalse(__CONDITION__, __COMMENT__, ...) \
            __FLAssertFalse(FLThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertFalse(__CONDITION__, __COMMENT__, ...) \
            __FLAssertFalse(FLCThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertValuesAreEqual(VALUE lhs, VALUE rhs)
// VALUE is anything that can be compared with "==". For example FLAssertValuesAreEqual(5,5)

#define FLConfirmValuesAreEqual(__LHS__, __RHS__) \
            __FLAssertValuesAreEqual(FLThrowAssertionFailure, __LHS__, __RHS__, nil)

#define FLCConfirmValuesAreEqual(__LHS__, __RHS__) \
            __FLAssertValuesAreEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, nil)


#define FLAssertValuesAreEqual(__LHS__, __RHS__, __COMMENT__, ...) \
            __FLAssertValuesAreEqual(FLThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertValuesAreEqual(__LHS__, __RHS__, __COMMENT__, ...) \
            __FLAssertValuesAreEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))


// FLAssertValuesAreNotEqual(VALUE lhs, VALUE rhs)
// VALUE is anything that can be compared with "!=". For example FLAssertValuesAreNotEqual(5,6)

#define FLConfirmValuesAreNotEqual(__LHS__, __RHS__) \
            __FLAssertValuesAreNotEqual(FLThrowAssertionFailure, __LHS__, __RHS__, nil)

#define FLCConfirmValuesAreNotEqual(__LHS__, __RHS__) \
            __FLAssertValuesAreNotEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, nil)

#define FLAssertValuesAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) \
            __FLAssertValuesAreNotEqual(FLThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertValuesAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) \
            __FLAssertValuesAreNotEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertObjectsAreEqual(id lhs, id rhs)
// this calls isEqual to compare objects.

#define FLConfirmObjectsAreEqual(__LHS__, __RHS__) \
            __FLAssertObjectsAreEqual(FLThrowAssertionFailure, __LHS__, __RHS__, nil)

#define FLCConfirmObjectsAreEqual(__LHS__, __RHS__) \
            __FLAssertObjectsAreEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, nil)

#define FLAssertObjectsAreEqual(__LHS__, __RHS__, __COMMENT__, ...) \
            __FLAssertObjectsAreEqual(FLThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertObjectsAreEqual(__LHS__, __RHS__, __COMMENT__, ...) \
            __FLAssertObjectsAreEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertObjectsAreNotEqual(id lhs, id rhs)
// this calls isEqual to compare objects.

#define FLConfirmObjectsAreNotEqual(__LHS__, __RHS__) \
            __FLAssertObjectsAreNotEqual(FLThrowAssertionFailure, __LHS__, __RHS__, nil)

#define FLCConfirmObjectsAreNotEqual(__LHS__, __RHS__) \
            __FLAssertObjectsAreNotEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, nil)

#define FLAssertObjectsAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) \
            __FLAssertObjectsAreNotEqual(FLThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertObjectsAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) \
            __FLAssertObjectsAreNotEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertType(id object, unquoted type name)
// example: FLAssertType([NSString string], NSString)

#define FLConfirmType(__OBJ__, __TYPE_NAME__) \
            __FLAssertType(FLThrowAssertionFailure, __OBJ__, __TYPE_NAME__, nil)

#define FLCConfirmType(__OBJ__, __TYPE_NAME__) \
            __FLAssertType(FLCThrowAssertionFailure, __OBJ__, __TYPE_NAME__, nil)

#define FLAssertType(__OBJ__, __TYPE_NAME__, __COMMENT__, ...) \
            __FLAssertType(FLThrowAssertionFailure, __OBJ__, __TYPE_NAME__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertType(__OBJ__, __TYPE_NAME__, __COMMENT__, ...) \
            __FLAssertType(FLCThrowAssertionFailure, __OBJ__, __TYPE_NAME__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertImplemented(__COMMENT__, ...)

#define FLConfirmImplemented() \
            __FLNotImplemented(FLThrowAssertionFailure,nil)

#define FLCConfirmImplemented() \
            __FLNotImplemented(FLCThrowAssertionFailure,nil)

#define FLAssertImplemented(__COMMENT__, ...) \
            __FLNotImplemented(FLThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCAssertImplemented(__COMMENT__, ...) \
            __FLNotImplemented(FLCThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLFixMe(__COMMENT__, ...)

//#define FLFixMe() \
//            __FLFixMe(FLThrowAssertionFailure,nil)
//
//#define FLCFixMe() \
//            __FLFixMe(FLCThrowAssertionFailure,nil)

#define FLFixMe(__COMMENT__, ...) \
            __FLFixMe(FLThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCFixMe(__COMMENT__, ...) \
            __FLFixMe(FLCThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))


// FLBug(..)

//#define FLBug() \
//        __FLBug(FLThrowAssertionFailure,nil)
//
//#define FLCBug() \
//        __FLBug(FLCThrowAssertionFailure,nil)

#define FLBug(__COMMENT__, ...) \
        __FLBug(FLThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

#define FLCBug(__COMMENT__, ...) \
        __FLBug(FLCThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))

// FLAssertDefaultInitNotCalled(__COMMENT__, ...)

#define FLConfirmDefaultInitNotCalled() \
            - (id) init { \
                FLThrowAssertionFailure(    FLFailureTypeUnsupportedInit, \
                                            nil, \
                                            nil); \
                return self; \
            }

#define FLAssertDefaultInitNotCalled(__COMMENT__, ...) \
            - (id) init { \
                FLThrowAssertionFailure(    FLFailureTypeUnsupportedInit, \
                                            nil, \
                                            FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)); \
                return self; \
            }


// FLIsRequiredOverride(__COMMENT__, ...)

#define FLConfirmRequiredOverride() \
            FLThrowAssertionFailure(FLFailureTypeRequiredOverride, nil , nil);

#define FLIsRequiredOverride(__COMMENT__, ...) \
            FLThrowAssertionFailure(FLFailureTypeRequiredOverride, nil , FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__));



#else

#define FLThrowAssertionFailure(__TYPE__, __REASON_OR_NIL__, __COMMENT_OR_NIL__)

#define FLAssert(__CONDITION__, __COMMENT__, ...) 

#define FLAssertFailed(__COMMENT__, ...) 
        
#define FLAssertNotNil(__POINTER__, __COMMENT__, ...) 

#define FLAssertNil(__POINTER__, __COMMENT__, ...) 

#define FLAssertStringIsNotEmpty(__STRING__, __COMMENT__, ...) 

#define FLAssertTrue(__CONDITION__, __COMMENT__, ...) 

#define FLAssertValuesAreEqual(__LHS__, __RHS__, __COMMENT__, ...) 

#define FLAssertValuesAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) 

#define FLAssertObjectsAreEqual(__LHS__, __RHS__, __COMMENT__, ...) 

#define FLAssertObjectsAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) 
    
#define FLAssertFalse(__CONDITION__, __COMMENT__, ...) 

#define FLAssertType(__OBJ__, __TYPE_NAME__, __COMMENT__, ...)

#define FLAssertDefaultInitNotCalled(__COMMENT__, ...)
		      
#define FLIsRequiredOverride(__COMMENT__, ...) \

#define FLAssertImplemented(__COMMENT__, ...) \

#define FLFixMe(__COMMENT__, ...)

#define FLBug(__COMMENT__, ...)

#endif


// Deprecated

#define FLAssertYes FLAssertTrue
#define FLAssertNo  FLAssertFalse
#define FLCAssertYes FLCAssertTrue
#define FLCAssertNo  FLCAssertFalse


