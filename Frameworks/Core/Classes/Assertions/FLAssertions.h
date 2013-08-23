//
//  FLAssertions.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"
#import "FLStringUtils.h"
#import "FLExceptions.h"
#import "FLAssertionFailureErrorDomain.h"
#import "FLAssertionFailedError.h"

#if !defined(ASSERTIONS) && (defined(DEBUG) || defined(TEST))
#define ASSERTIONS 1
#endif

#import "FLConfirmations.h"

#if ASSERTIONS
    #define FLAssert                       FLConfirm
    #define FLAssertWithComment                      FLConfirmWithComment
    #define FLAssertFailed                 FLConfirmationFailure
    #define FLAssertFailedWithComment                FLConfirmationFailureWithComment
    #define FLAssertIsNil                  FLConfirmIsNil
    #define FLAssertIsNilWithComment                 FLConfirmIsNilWithComment
    #define FLAssertIsNotNil               FLConfirmIsNotNil
    #define FLAssertIsNotNilWithComment              FLConfirmIsNotNilWithComment
    #define FLAssertStringIsNotEmpty       FLConfirmStringIsNotEmpty
    #define FLAssertStringIsNotEmptyWithComment      FLConfirmStringIsNotEmptyWithComment
    #define FLAssertStringIsEmpty          FLConfirmStringIsEmpty
    #define FLAssertStringIsEmptyWithComment         FLConfirmStringIsEmptyWithComment
    #define FLAssertIsTrue                 FLConfirmIsTrue
    #define FLAssertIsTrueWithComment                FLConfirmIsTrueWithComment
    #define FLAssertIsFalse                FLConfirmIsFalse
    #define FLAssertIsFalseWithComment               FLConfirmIsFalseWithComment
    #define FLAssertIsYes                  FLConfirmIsYes
    #define FLAssertIsYesWithComment                 FLConfirmIsYesWithComment
    #define FLAssertIsNo                   FLConfirmIsNo
    #define FLAssertIsNoWithComment                  FLConfirmIsNoWithComment
    #define FLAssertAreEqual               FLConfirmAreEqual
    #define FLAssertAreEqualWithComment              FLConfirmAreEqualWithComment
    #define FLAssertAreNotEqual            FLConfirmAreNotEqual
    #define FLAssertAreNotEqualWithComment           FLConfirmAreNotEqualWithComment
    #define FLAssertObjectsAreEqual        FLConfirmObjectsAreEqual
    #define FLAssertObjectsAreEqualWithComment       FLConfirmObjectsAreEqualWithComment
    #define FLAssertObjectsAreNotEqual     FLConfirmObjectsAreNotEqual
    #define FLAssertObjectsAreNotEqualWithComment    FLConfirmObjectsAreNotEqualWithComment
    #define FLAssertIsKindOfClass          FLConfirmIsKindOfClass
    #define FLAssertIsKindOfClassWithComment         FLConfirmIsKindOfClassWithComment
    #define FLAssertIsImplemented          FLConfirmIsImplemented
    #define FLAssertIsImplementedWithComment         FLConfirmIsImplementedWithComment
    #define FLAssertIsFixed                FLConfirmIsFixed
    #define FLAssertIsFixedWithComment               FLConfirmIsFixedWithComment
    #define FLAssertIsBug                  FLConfirmIsBug
    #define FLAssertIsBugWithComment                 FLConfirmIsBugWithComment
    #define FLAssertIsOverridden           FLConfirmIsOverridden 
    #define FLAssertIsOverriddenWithComment          FLConfirmIsOverriddenWithComment

    extern id _FLAssertIsClass(id object, Class class);
    extern id _FLAssertConformsToProtocol(id object, Protocol* proto);

    #define FLAssertIsClass(__OBJ__, __CLASS__) \
        _FLAssertIsClass(__OBJ__, __CLASS__)

    #define FLAssertConformsToProtocol(__OBJ__, __PROTOCOL__) \
        _FLAssertConformsToProtocol(__OBJ__, NSProtocolFromString(@#__PROTOCOL__))


    #define FLAssertDefaultInitNotCalledWithComment(__FORMAT__, ...) \
                - (id) init { \
                    FLAssertFailedWithComment(@"unsupported call to default init: %@", FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)); \
                    return self; \
                }

    #define FLAssertDefaultInitNotCalled() \
                - (id) init { \
                    FLAssertFailedWithComment(@"unsupported call to default init"); \
                    return self; \
                }


#else
    #define FLAssert(...) 
    #define FLAssertWithComment(...) 
    #define FLAssertFailed() 
    #define FLAssertFailedWithComment(...) 
    #define FLAssertIsNil(...) 
    #define FLAssertIsNilWithComment(...) 
    #define FLAssertIsNotNil(...) 
    #define FLAssertIsNotNilWithComment(...) 
    #define FLAssertStringIsNotEmpty(...) 
    #define FLAssertStringIsNotEmptyWithComment(...) 
    #define FLAssertStringIsEmpty(...) 
    #define FLAssertStringIsEmptyWithComment(...) 
    #define FLAssertIsTrue(...) 
    #define FLAssertIsTrueWithComment(...) 
    #define FLAssertIsFalse(...) 
    #define FLAssertIsFalseWithComment(...) 
    #define FLAssertIsYes(...) 
    #define FLAssertIsYesWithComment(...) 
    #define FLAssertIsNo(...) 
    #define FLAssertIsNoWithComment(...) 
    #define FLAssertAreEqual(...) 
    #define FLAssertAreEqualWithComment(...) 
    #define FLAssertAreNotEqual(...) 
    #define FLAssertAreNotEqualWithComment(...) 
    #define FLAssertObjectsAreEqual(...) 
    #define FLAssertObjectsAreEqualWithComment(...) 
    #define FLAssertObjectsAreNotEqual(...) 
    #define FLAssertObjectsAreNotEqualWithComment(...) 
    #define FLAssertIsKindOfClass(...) 
    #define FLAssertIsKindOfClassWithComment(...) 
    #define FLAssertIsImplemented() 
    #define FLAssertIsImplementedWithComment(...) 
    #define FLAssertIsFixed() 
    #define FLAssertIsFixedWithComment(...) 
    #define FLAssertIsBug() 
    #define FLAssertIsBugWithComment(...) 
    #define FLAssertIsOverridden() 
    #define FLAssertIsOverriddenWithComment(...) 

    #define FLAssertDefaultInitNotCalledWithComment(__FORMAT__, ...)
    #define FLAssertDefaultInitNotCalled()

    #define FLFixMe_ FLAssertIsFixed
    #define FLFixMeWithComment FLAssertIsFixedWithComment

    #define FLAssertObjectIsType(__OBJ__, __TYPE__) __OBJ__
    #define FLAssertConformsToProtocol(__OBJ__, __PROTOCOL__) __OBJ__

#endif

#define FLAssertNotNil         FLAssertIsNotNil
#define FLAssertNotNilWithComment        FLAssertIsNotNilWithComment
#define FLAssertNil            FLAssertIsNil
#define FLAssertNilWithComment           FLAssertIsNilWithComment

#define FLAssertionFailedWithComment FLAssertFailedWithComment
#define FLAssertionFailed FLAssertFailed
