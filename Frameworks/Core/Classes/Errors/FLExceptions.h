//
//  FLExceptions.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"
#import "FLStackTrace.h"
#import "NSError+FLExtras.h"

#ifndef __INCLUDE_STACK_TRACE__
#define __INCLUDE_STACK_TRACE__ YES
#endif

typedef NSException* FLWillThrowExceptionHandler(NSException *exception);

extern void FLSetWillThrowExceptionHandler(FLWillThrowExceptionHandler* handler);

extern FLWillThrowExceptionHandler* FLGetWillThrowExceptionHandler();

#define FL_THROW_ERROR(__ERROR__, __THROWER__) \
            do {  \
                NSError* __error = __ERROR__; \
                if(!__error.stackTrace) { \
                    __error = [NSError errorWithError:__error stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]; \
                } \
                \
                __THROWER__([__error createContainingException]); \
            } \
            while(0)

#define FLThrowException(__EX__) \
            @throw FLGetWillThrowExceptionHandler()(__EX__)

#define FLThrowError(__ERROR__) \
            FL_THROW_ERROR(__ERROR__, FLThrowException)

//            do {  \
//                NSError* __error = __ERROR__; \
//                if(!__error.stackTrace) { \
//                    __error = [NSError errorWithError:__error stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]; \
//                } \
//                \
//                FLThrowException([__error createContainingException]); \
//            } \
//            while(0)


#define FLThrowIfError(__OBJECT__) \
            do { \
                id __object = (id)(__OBJECT__);\
                if([__object isError]) { \
                    FLThrowError(__object); \
                } \
            } while(0)

#define FLThrowErrorCodeWithComment(__DOMAIN__, __CODE__, __FORMAT__, ...) \
            FLThrowError([NSError errorWithDomain:__DOMAIN__ \
                            code:__CODE__ \
                            localizedDescription: nil \
                            userInfo:nil \
                            comment:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__) \
                            stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)])

#define FLThrowErrorCode(__DOMAIN__, __CODE__) \
            FLThrowError([NSError errorWithDomain:__DOMAIN__ \
                            code:__CODE__ \
                            localizedDescription:nil \
                            userInfo:nil \
                            comment:nil \
                            stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)])
