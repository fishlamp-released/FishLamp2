//
//  FLFailureErrorDomain.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

