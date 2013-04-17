//
//  FLFailureErrorDomain.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"
#import "FLErrorDomainInfo.h"

extern NSString* const FLErrorDomain;

typedef enum {
    FLErrorCodeCancel = kCFURLErrorCancelled,
    FLErrorCodeTimedOut = kCFURLErrorTimedOut,
    
    FLErrorCodeNone = noErr,
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
    FLErrorResultFailed,
    FLUnhandledServiceRequestErrorCode,
} FLErrorCode;

@interface FLFrameworkErrorDomainInfo : NSObject<FLErrorDomainInfo>
+ (id) frameworkErrorDomainInfo;
@end

