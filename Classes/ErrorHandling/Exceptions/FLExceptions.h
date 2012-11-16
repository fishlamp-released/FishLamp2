//
//  FLExceptions.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSException+NSError.h"
#import "FLMutableError.h"
#import "FLStackTrace.h"
#import "FLErrorDomain.h"
#import "FLFrameworkErrorDomain.h"

#ifndef __INCLUDE_STACK_TRACE__
#define __INCLUDE_STACK_TRACE__ YES
#endif

@protocol FLErrorAwareObject <NSObject>
@property (readonly, strong) NSError* error;
@end

NS_INLINE
id FLThrowError(id object) {
    if(!object) {
        return nil;
    }
    NSError* error = [object error];
    if(!error) { 
        return object;
    }

    @throw [NSException exceptionWithError:[FLMutableError mutableErrorWithError:error stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]];
}

#define FLThrowError_(__ERROR__) \
            FLThrowError(__ERROR__)

#define FLThrowErrorCode_v(__DOMAIN_OBJECT_OR_STRING__, __CODE__, __FORMAT__, ...) \
            @throw [NSException exceptionWithError: \
                    [FLMutableError errorWithDomain:__DOMAIN_OBJECT_OR_STRING__ \
                            code:(__CODE__) \
                            userInfo:nil \
                            reason:(FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)) \
                            comment:nil \
                            stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]]

#define FLThrowFailure_(__DOMAIN_OBJECT_OR_STRING__, __TYPE__, __REASON_OR_NIL__, __COMMENT_OR_NIL__) \
            @throw [NSException exceptionWithError: \
                    [FLMutableError errorWithDomain:__DOMAIN_OBJECT_OR_STRING__ \
                            code:(__TYPE__) \
                            userInfo:nil \
                            reason:__REASON_OR_NIL__ \
                            comment:__COMMENT_OR_NIL__ \
                            stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]]

// TODO move this
#define FLThrowCancelException() \
    FLThrowErrorCode_v(FLFrameworkErrorDomainName, FLCancelErrorCode, NSLocalizedString(@"Cancelled", nil))

// deprecate this? Use assertions?

#define FLThrowIfStringEmpty(__STRING__) \
    if(FLStringIsEmpty(__STRING__)) \
        FLThrowErrorCode_v(   FLFrameworkErrorDomain, \
                            FLErrorEmptyStringErrorCode, \
                            @"unexpected empty string: %s", #__STRING__)

#define FLThrowIfNil(__POINTER__) \
    if((__POINTER__) == nil) \
        FLThrowErrorCode_v(   FLFrameworkErrorDomain, \
                            FLErrorUnexpectedNilObject, \
                            @"unexpected nil pointer: %s", #__POINTER__)


#define FLThrowIfStringEmpty(__STRING__) \
    if(FLStringIsEmpty(__STRING__)) \
        FLThrowErrorCode_v(  FLFrameworkErrorDomain, \
                            FLErrorEmptyStringErrorCode, \
                            @"unexpected empty string: %s", #__STRING__)



#define FLCThrowFailure_ FLThrowFailure_
#define FLCThrowError_ FLThrowError_