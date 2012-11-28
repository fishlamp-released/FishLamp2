//
//  FLAssertions.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLRequired.h"
#import "FLExceptions.h"
#import "FLStringUtils.h"
#import "FLAssertionFailureErrorDomain.h"

#if !defined(ASSERTIONS) && (defined(DEBUG) || defined(TEST))
#define ASSERTIONS 1
#endif

#import "FLConfirmations.h"

#if ASSERTIONS
    #define FLAssert_                       FLConfirm_
    #define FLAssert_v                      FLConfirm_v
    #define FLAssertFailed_                 FLConfirmationFailure_
    #define FLAssertFailed_v                FLConfirmationFailure_v
    #define FLAssertIsNil_                  FLConfirmIsNil_
    #define FLAssertIsNil_v                 FLConfirmIsNil_v
    #define FLAssertIsNotNil_               FLConfirmIsNotNil_
    #define FLAssertIsNotNil_v              FLConfirmIsNotNil_v
    #define FLAssertStringIsNotEmpty_       FLConfirmStringIsNotEmpty_
    #define FLAssertStringIsNotEmpty_v      FLConfirmStringIsNotEmpty_v
    #define FLAssertStringIsEmpty_          FLConfirmStringIsEmpty_
    #define FLAssertStringIsEmpty_v         FLConfirmStringIsEmpty_v
    #define FLAssertIsTrue_                 FLConfirmIsTrue_
    #define FLAssertIsTrue_v                FLConfirmIsTrue_v
    #define FLAssertIsFalse_                FLConfirmIsFalse_
    #define FLAssertIsFalse_v               FLConfirmIsFalse_v
    #define FLAssertIsYes_                  FLConfirmIsYes_
    #define FLAssertIsYes_v                 FLConfirmIsYes_v
    #define FLAssertIsNo_                   FLConfirmIsNo_
    #define FLAssertIsNo_v                  FLConfirmIsNo_v
    #define FLAssertAreEqual_               FLConfirmAreEqual_
    #define FLAssertAreEqual_v              FLConfirmAreEqual_v
    #define FLAssertAreNotEqual_            FLConfirmAreNotEqual_
    #define FLAssertAreNotEqual_v           FLConfirmAreNotEqual_v
    #define FLAssertObjectsAreEqual_        FLConfirmObjectsAreEqual_
    #define FLAssertObjectsAreEqual_v       FLConfirmObjectsAreEqual_v
    #define FLAssertObjectsAreNotEqual_     FLConfirmObjectsAreNotEqual_
    #define FLAssertObjectsAreNotEqual_v    FLConfirmObjectsAreNotEqual_v
    #define FLAssertIsKindOfClass_          FLConfirmIsKindOfClass_
    #define FLAssertIsKindOfClass_v         FLConfirmIsKindOfClass_v
    #define FLAssertIsImplemented_          FLConfirmIsImplemented_
    #define FLAssertIsImplemented_v         FLConfirmIsImplemented_v
    #define FLAssertIsFixed_                FLConfirmIsFixed_
    #define FLAssertIsFixed_v               FLConfirmIsFixed_v
    #define FLAssertIsBug_                  FLConfirmIsBug_
    #define FLAssertIsBug_v                 FLConfirmIsBug_v
    #define FLAssertIsOverridden_           FLConfirmIsOverridden_ 
    #define FLAssertIsOverridden_v          FLConfirmIsOverridden_v

    NS_INLINE
    id _FLAssertIsType(id object, Class aClass) {
        if(object) {
            FLAssert_v([object isKindOfClass:aClass], 
                @"expecting type of %@ but got %@", 
                NSStringFromClass(aClass), 
                NSStringFromClass([object class]));
        }
        return object;
    }

    NS_INLINE
    id _FLAssertConformsToProtocol(id object, Protocol* proto) {
        if(object) {
            FLAssert_v([object conformsToProtocol:proto], @"expecting object to implement protocol: %@", NSStringFromProtocol(proto));
        }
        return object;
    }

    #define FLAssertIsType(__OBJ__, __TYPE__) \
        _FLAssertIsType(__OBJ__, NSClassFromString(@#__TYPE__))

    #define FLAssertConformsToProtocol(__OBJ__, __PROTOCOL__) \
        _FLAssertConformsToProtocol(__OBJ__, NSProtocolFromString(@#__PROTOCOL__))


    #define FLAssertDefaultInitNotCalled_v(__FORMAT__, ...) \
                - (id) init { \
                    FLAssertFailed_v(@"unsupported call to default init: %@", FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)); \
                    return self; \
                }

    #define FLAssertDefaultInitNotCalled_() \
                - (id) init { \
                    FLAssertFailed_v(@"unsupported call to default init"); \
                    return self; \
                }


#else
    #define FLAssert(...) 
    #define FLAssertv(...) 
    #define FLAssertFailed_() 
    #define FLAssertFailed_v(...) 
    #define FLAssertIsNil_(...) 
    #define FLAssertIsNil_v(...) 
    #define FLAssertIsNotNil_(...) 
    #define FLAssertIsNotNil_v(...) 
    #define FLAssertStringIsNotEmpty_(...) 
    #define FLAssertStringIsNotEmpty_v(...) 
    #define FLAssertStringIsEmpty_(...) 
    #define FLAssertStringIsEmpty_v(...) 
    #define FLAssertIsTrue_(...) 
    #define FLAssertIsTrue_v(...) 
    #define FLAssertIsFalse_(...) 
    #define FLAssertIsFalse_v(...) 
    #define FLAssertIsYes_(...) 
    #define FLAssertIsYes_v(...) 
    #define FLAssertIsNo_(...) 
    #define FLAssertIsNo_v(...) 
    #define FLAssertAreEqual_(...) 
    #define FLAssertAreEqual_v(...) 
    #define FLAssertAreNotEqual_(...) 
    #define FLAssertAreNotEqual_v(...) 
    #define FLAssertObjectsAreEqual_(...) 
    #define FLAssertObjectsAreEqual_v(...) 
    #define FLAssertObjectsAreNotEqual_(...) 
    #define FLAssertObjectsAreNotEqual_v(...) 
    #define FLAssertIsKindOfClass_(...) 
    #define FLAssertIsKindOfClass_v(...) 
    #define FLAssertIsImplemented_() 
    #define FLAssertIsImplemented_v(...) 
    #define FLAssertIsFixed_() 
    #define FLAssertIsFixed_v(...) 
    #define FLAssertIsBug_() 
    #define FLAssertIsBug_v(...) 
    #define FLAssertIsOverridden_() 
    #define FLAssertIsOverridden_v(...) 

    #define FLAssertDefaultInitNotCalled_v(__FORMAT__, ...)
    #define FLAssertDefaultInitNotCalled_()

    #define FLFixMe_ FLAssertIsFixed_
    #define FLFixMe_v FLAssertIsFixed_v

    #define FLAssertIsType(__OBJ__, __TYPE__) __OBJ__
    #define FLAssertConformsToProtocol(__OBJ__, __PROTOCOL__) __OBJ__

#endif

#define FLAssertNotNil_         FLAssertIsNotNil_
#define FLAssertNotNil_v        FLAssertIsNotNil_v
#define FLAssertNil_            FLAssertIsNil_
#define FLAssertNil_v           FLAssertIsNil_v
