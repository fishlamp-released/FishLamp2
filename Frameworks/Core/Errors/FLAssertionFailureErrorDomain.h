//
//  FLAssertionFailureErrorDomain.h
//  FishLampSync
//
//  Created by Mike Fullerton on 11/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLErrorDomainInfo.h"
#import "FLFrameworkErrorDomain.h"

extern NSString* const FLAssertionFailureErrorDomain;

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

@interface FLAssertionFailureErrorDomainInfo : NSObject<FLErrorDomainInfo>

+ (id) assertionFailureErrorDomainInfo;
@end

