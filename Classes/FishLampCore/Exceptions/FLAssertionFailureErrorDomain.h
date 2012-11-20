//
//  FLAssertionFailureErrorDomain.h
//  FishLampSync
//
//  Created by Mike Fullerton on 11/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLErrorDomain.h"
#import "FLFrameworkErrorDomain.h"

typedef enum {
    FLAssertionFailureNone,
    FLAssertionFailureCondition,
    FLAssertionFailureAreEqual,
    FLAssertionFailureAreNotEqual,
    FLAssertionFailureIsNil,
    FLAssertionFailureIsNotNil,
    FLAssertionFailureIsEmpty,
    FLAssertionFailureIsNotEmpty,
    FLAssertionFailureIsTrue,
    FLAssertionFailureIsFalse,
    FLAssertionFailureIsWrongType,

// logic
    FLAssertionFailureUnsupportedInit,
    FLAssertionFailureNotImplemented,
    FLAssertionFailureFixMe,
    FLAssertionFailureBug,
    FLAssertionFailureRequiredOverride
} FLAssertionFailure;

@interface FLAssertionFailureErrorDomain : NSObject<FLErrorDomain>
@end

