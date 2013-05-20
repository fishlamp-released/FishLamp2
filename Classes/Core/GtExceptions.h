//
//  GtExceptions.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSException+GtExtras.h"
#import "NSError+GtExtras.h"

#define GtThrowException(__EXCEPTION__) \
    @throw __EXCEPTION__

#define GtThrowError(__ERROR__) \
    GtThrowException([NSException exceptionWithError:(__ERROR__)]) 

#define GtThrowErrorCode(__DOMAIN__, __CODE__, __FORMAT__, ...) \
    GtThrowError(   [NSError errorWithDomain:__DOMAIN__ \
                                        code:__CODE__ \
                        localizedDescription:(GtStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__))]) 

#define GtThrowIfStringEmpty(__STRING__) \
    if(GtStringIsEmpty(__STRING__)) \
        GtThrowErrorCode(   GtErrorDomain, \
                            GtErrorEmptyStringErrorCode, \
                            @"unexpected empty string: %s", #__STRING__)

#define GtThrowIfNil(__POINTER__) \
    if((__POINTER__) == nil) \
        GtThrowErrorCode(   GtErrorDomain, \
                            GtErrorUnexpectedNilObject, \
                            @"unexpected nil pointer: %s", #__POINTER__)
        
#define GtThrowCancelException() \
    GtThrowError([NSError cancelError])
    
// FIXME    
#define GtThrowExceptionWithString(string, comment) 

#define GtFailIf(condition, domain, code, comment, ...) \
            if(condition) GtThrowErrorCode(domain, code, comment, ##__VA_ARGS__)