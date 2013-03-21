//
//  FLFailureErrorDomain.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"
#import "FLErrorDomainInfo.h"

extern NSString* const FLFrameworkErrorDomain;

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
    FLErrorResultFailed,
    FLUnhandledServiceRequestErrorCode,
    
    FLSoapFaultError,
    FLFrameworkTcpStreamErrorCode
} FLFrameworkErrorCode;

@interface FLFrameworkErrorDomainInfo : NSObject<FLErrorDomainInfo>
+ (id) frameworkErrorDomainInfo;
@end

