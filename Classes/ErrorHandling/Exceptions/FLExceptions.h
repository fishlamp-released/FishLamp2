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


#define FLThrow(__EX__) [__EX__ raise] 

NS_INLINE
NSException* FLErrorExceptionFromObject(id object) {
    NSError* error = [object error];
    return error != nil ? [NSException exceptionWithError: 
                            [FLMutableError mutableErrorWithError:error stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]] : nil;
}

#define FLThrowException_(__EX__) \
            FLThrow(__EX__)

#define FLCThrowException_(__EX__) \
            FLThrow(__EX__)

#define FLThrowError_(__ERROR__) \
            FLThrowException_(FLErrorExceptionFromObject(__ERROR__)) 

#define FLCThrowError_(__ERROR__) \
            FLCThrowException_(FLErrorExceptionFromObject(__ERROR__)) 

#define FLThrowErrorCode_v(__DOMAIN_OBJECT_OR_STRING__, __CODE__, __FORMAT__, ...) \
            FLThrowException_( \
                [NSException exceptionWithError: \
                    [FLMutableError errorWithDomain:__DOMAIN_OBJECT_OR_STRING__ \
                            code:(__CODE__) \
                            userInfo:nil \
                            reason:(FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)) \
                            comment:nil \
                            stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]])
                            
#define FLCThrowErrorCode_v(__DOMAIN_OBJECT_OR_STRING__, __CODE__, __FORMAT__, ...) \
            FLCThrowException_( \
                [NSException exceptionWithError: \
                    [FLMutableError errorWithDomain:__DOMAIN_OBJECT_OR_STRING__ \
                            code:(__CODE__) \
                            userInfo:nil \
                            reason:(FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)) \
                            comment:nil \
                            stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]])

#define FLThrowIfError_(__ERROR__) \
            do { \
                NSError* __ERR = __ERROR__; \
                if(__ERR) FLThrowError_(__ERR); \
            } while(0)

#define FLCThrowIfError_(__ERROR__) \
            do { \
                NSError* __ERR = __ERROR__; \
                if(__ERR) FLCThrowError_(__ERR); \
            } while(0)

#define FLThrowFailure_(__DOMAIN_OBJECT_OR_STRING__, __TYPE__, __REASON_OR_NIL__, __COMMENT_OR_NIL__) \
            FLThrowException_( \
                [NSException exceptionWithError: \
                    [FLMutableError errorWithDomain:__DOMAIN_OBJECT_OR_STRING__ \
                            code:(__TYPE__) \
                            userInfo:nil \
                            reason:__REASON_OR_NIL__ \
                            comment:__COMMENT_OR_NIL__ \
                            stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]])

#define FLCThrowFailure_(__DOMAIN_OBJECT_OR_STRING__, __TYPE__, __REASON_OR_NIL__, __COMMENT_OR_NIL__) \
            FLCThrowException_( \
                [NSException exceptionWithError: \
                    [FLMutableError errorWithDomain:__DOMAIN_OBJECT_OR_STRING__ \
                            code:(__TYPE__) \
                            userInfo:nil \
                            reason:__REASON_OR_NIL__ \
                            comment:__COMMENT_OR_NIL__ \
                            stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]])

// TODO move this
#define FLThrowCancelException() \
    FLThrowErrorCode_v(FLFrameworkErrorDomainName, FLCancelErrorCode, NSLocalizedString(@"Cancelled", nil))

#define FLCThrowCancelException() \
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



