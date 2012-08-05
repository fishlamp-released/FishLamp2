//
//  FLExceptions.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"
#import "NSException+FLExtras.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

typedef void (*FLExceptionHook)(const char* function, const char* file, int line, NSException* exception);

extern void FLSetExceptionHook(FLExceptionHook hook);    

extern FLExceptionHook FLGetExceptionHook();

// this inline function is some handwaving so that the debugger stops in the right place in xcode.
// Also it get the stack trace correct (e.g. __FLWillThrowException doesn't show up on the stack)
NS_INLINE 
NSException* __FLWillThrowException(const char* function, const char* file, int line, NSException* exception) {
    
    FLExceptionHook hook = FLGetExceptionHook();
    if(hook) {
        hook(function, file, line, exception); 
    }
        
    return exception;
}

// see comment at __FLWillThrowException
#define FLThrowException(__EXCEPTION__) \
    @throw __FLWillThrowException(  __PRETTY_FUNCTION__, \
                                    __FILE__, \
                                    __LINE__, \
                                    __EXCEPTION__)

#define FLThrowError(__ERROR__) \
    FLThrowException([NSException exceptionWithError:(__ERROR__)]) 

#define FLThrowErrorCode(__DOMAIN__, __CODE__, __FORMAT__, ...) \
    FLThrowError(   [NSError errorWithDomain:__DOMAIN__ \
                                        code:__CODE__ \
                        localizedDescription:(FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__))]) 

#define FLThrowIfStringEmpty(__STRING__) \
    if(FLStringIsEmpty(__STRING__)) \
        FLThrowErrorCode(   FLErrorDomain, \
                            FLErrorEmptyStringErrorCode, \
                            @"unexpected empty string: %s", #__STRING__)

#define FLThrowIfNil(__POINTER__) \
    if((__POINTER__) == nil) \
        FLThrowErrorCode(   FLErrorDomain, \
                            FLErrorUnexpectedNilObject, \
                            @"unexpected nil pointer: %s", #__POINTER__)
        
#define FLThrowCancelException() \
    FLThrowError([NSError cancelError])
    
