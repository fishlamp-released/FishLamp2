//
//  FLFailureErrorDomain.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFrameworkErrorDomain.h"

@implementation FLFrameworkErrorDomain

FLSynthesizeSingleton(FLFrameworkErrorDomain);

- (NSString*) stringFromErrorCode:(int) errorCode {

    switch((FLFrameworkErrorCode) errorCode) {
    
        case FLErrorCodeNone:
            return @"com.fishlamp.error.no-error";
        break;
        
        case FLCancelErrorCode:
            return @"com.fishlamp.error.cancel";
        break;
        case FLAbortErrorCode:
            return @"com.fishlamp.error.abort";
        break;
        case FLErrorEmptyStringErrorCode:
            return @"com.fishlamp.error.empty-string";
        break;
        case FLErrorUnexpectedNilObject:
            return @"com.fishlamp.error.unexpected-nil";
        break;
        case FLErrorInvalidFolder:
            return @"com.fishlamp.error.invalid-folder";
        break;
        case FLErrorInvalidName:
            return @"com.fishlamp.error.invalid-name";
        break;
        case FLErrorNoDataToSave:
            return @"com.fishlamp.error.no-data";
        break;
        case FLErrorDuplicateItemErrorCode:
            return @"com.fishlamp.error.duplicate";
        break;
        case FLErrorUnknownEnumValue:
            return @"com.fishlamp.error.unknown-enum";
        break;
        case FLErrorConditionFailed:
            return @"com.fishlamp.error.condition-failed";
        break;
        case FLErrorTooManyEnumsErrorCode:
            return @"com.fishlamp.error.too-many-enums";
        break;
        case FLActionErrorCodeConfigScope:
            return @"com.fishlamp.error.config-scope";
        break;
        case FLActionErrorCodeInvalidContext:
            return @"com.fishlamp.error.invalid-context";
        break;
        case FLAuthenticationErrorPasswordIncorrect:
            return @"com.fishlamp.error.authentication-failed";
        break;
        case FLAuthenticationErrorPasswordIncorrectOffline:
            return @"com.fishlamp.error.authentication-failed.offline";
        break;
        case FLSoapFaultError:
            return @"com.fishlamp.error.http.soap";
        break;
        case FLFrameworkTcpStreamErrorCode:
            return @"com.fishlamp.error.tcp";
        break;
        
        case FLErrorResultFailed:
            return @"com.fishlamp.error.results-failed";
        break;
        
        case FLUnhandledServiceRequestErrorCode:
            return @"com.fishlamp.error.unhandled-service-request";
        break;
    }
    return @"";
}

- (NSString*) errorDomainString {
    return @"com.fishlamp.error";
}
@end


