//
//  FLAssertions.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLObjc.h"
#import "FLCompilerWarnings.h"

#import "FLExceptions.h"
#import "FLStringUtils.h"

#define FLAssertionComment FLStringWithFormatOrNil

typedef enum {
    FLFailureTypeNone,
    FLFailureTypeCondition,
    FLFailureTypeAreEqual,
    FLFailureTypeAreNotEqual,
    FLFailureTypeIsNil,
    FLFailureTypeIsNotNil,
    FLFailureTypeIsEmpty,
    FLFailureTypeIsNotEmpty,
    FLFailureTypeIsTrue,
    FLFailureTypeIsFalse,
    FLFailureTypeIsWrongType,

// logic
    FLFailureTypeUnsupportedInit,
    FLFailureTypeNotImplemented,
    FLFailureTypeFixMe,
    FLFailureTypeBug,
    FLFailureTypeRequiredOverride
} FLFailureType;

FLDeclareErrorDomain(FLAssertionFailureErrorDomain);

#import "FLAssertions_Generated.h"
#import "FLConfirmations_Generated.h"

#define FLAssertDefaultInitNotCalled_v(__FORMAT__, ...)
#define FLAssertDefaultInitNotCalled_()

#define FLFixMe_ FLAssertIsFixed_
#define FLFixMe_v FLAssertIsFixed_v



#if DEBUG

NS_INLINE
id _FLAssertIsType(id object, Class class) {
    if(object) {
        FLCAssert_v([object isKindOfClass:class], @"expecting type of %@", NSStringFromClass(class));
    }
    return object;
}

NS_INLINE
id _FLAssertConformsToProtocol(id object, Protocol* proto) {
    if(object) {
        FLCAssert_v([object conformsToProtocol:proto], @"expecting object to implement protocol: %@", NSStringFromProtocol(proto));
    }
    return object;
}

#define FLAssertIsType(__OBJ__, __TYPE__) \
    _FLAssertIsType(__OBJ__, NSClassFromString(@#__TYPE__))

#define FLAssertConformsToProtocol(__OBJ__, __PROTOCOL__) \
    _FLAssertConformsToProtocol(__OBJ__, NSProtocolFromString(@#__PROTOCOL__))

#else

#define FLAssertIsType(__OBJ__, __TYPE__) __OBJ__

#define FLAssertConformsToProtocol(__OBJ__, __PROTOCOL__) __OBJ__

#endif


#define FLAssertNotNil_         FLAssertIsNotNil_
#define FLAssertNotNil_v        FLAssertIsNotNil_v
#define FLAssertNil_            FLAssertIsNil_
#define FLAssertNil_v           FLAssertIsNil_v
#define FLCAssertNotNil_         FLCAssertIsNotNil_
#define FLCAssertNotNil_v        FLCAssertIsNotNil_v
#define FLCAssertNil_            FLCAssertIsNil_
#define FLCAssertNil_v           FLCAssertIsNil_v


#define FLConfirmNotNil_         FLConfirmIsNotNil_
#define FLConfirmNotNil_v        FLConfirmIsNotNil_v
#define FLConfirmNil_            FLConfirmIsNil_
#define FLConfirmNil_v           FLConfirmIsNil_v
#define FLCConfirmNotNil_         FLCConfirmIsNotNil_
#define FLCConfirmNotNil_v        FLCConfirmIsNotNil_v
#define FLCConfirmNil_            FLCConfirmIsNil_
#define FLCConfirmNil_v           FLCConfirmIsNil_v
