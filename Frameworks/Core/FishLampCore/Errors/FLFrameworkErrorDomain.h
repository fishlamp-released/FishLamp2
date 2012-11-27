//
//  FLFailureErrorDomain.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"
#import "FLErrorDomain.h"

typedef enum {
    FLErrorCodeNone,
    FLCancelErrorCode,
    FLAbortErrorCode,
    FLErrorEmptyStringErrorCode,
    FLErrorUnexpectedNilObject,
    FLErrorInvalidFolder,
    FLErrorInvalidName,
    FLErrorNoDataToSave,
    FLErrorDuplicateItemErrorCode,
    FLErrorUnknownEnumValue,
    FLErrorConditionFailed,
    FLErrorTooManyEnumsErrorCode,
	FLActionErrorCodeConfigScope,
	FLActionErrorCodeInvalidContext,
	FLAuthenticationErrorPasswordIncorrect,
	FLAuthenticationErrorPasswordIncorrectOffline,

    FLSoapFaultError,
    FLFrameworkTcpStreamErrorCode
} FLFrameworkErrorCode;

@interface FLFrameworkErrorDomain : NSObject<FLErrorDomain>
@end

