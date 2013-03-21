//
//  FLExceptions.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLRequired.h"
#import "FLErrorException.h"
#import "FLMutableError.h"
#import "FLStackTrace.h"
#import "FLErrorDomainInfo.h"
#import "FLFrameworkErrorDomain.h"

@interface NSError (FLExceptionCreation)
- (NSException*) createException:(NSDictionary*) userInfo;

- (NSException*) createExceptionWithStackTrace:(FLStackTrace_t) stackTrace 
                                      userInfo:(NSDictionary*) userInfo;
@end

#ifndef __INCLUDE_STACK_TRACE__
#define __INCLUDE_STACK_TRACE__ YES
#endif

#define FLThrowException(__EX__) [__EX__ raise]
#define FLThrowErrorWithLoc(__ERROR__, __LOC__) FLThrowException([__ERROR__ createExceptionWithStackTrace:FLStackTraceMake(__LOC__, __INCLUDE_STACK_TRACE__) userInfo:nil])
#define FLThrowError(__ERROR__) FLThrowErrorWithLoc(__ERROR__, __FILE_LOCATION__)


NS_INLINE 
id __FLThrowIfError(id object, FLLocationInSourceFile_t loc) {
    if([object error]) {
        FLThrowErrorWithLoc([object error], loc);
    }
    return object;
}

#define FLThrowIfError(__OBJECT__) __FLThrowIfError(__OBJECT__, __FILE_LOCATION__)

#define FLThrowErrorCodeWithComment(__DOMAIN_OBJECT_OR_STRING__, __CODE__, __FORMAT__, ...) \
            FLThrowError([NSError errorWithDomain:__DOMAIN_OBJECT_OR_STRING__ \
                            code:(__CODE__) \
                            localizedDescription: nil \
                            userInfo:nil \
                            comment:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)])

#define FLThrowErrorCode(__DOMAIN_OBJECT_OR_STRING__, __CODE__) \
            FLThrowError([NSError errorWithDomain:__DOMAIN_OBJECT_OR_STRING__ \
                            code:(__CODE__) \
                            localizedDescription:nil \
                            userInfo:nil \
                            comment:nil])

//#define FLThrowFailure_(__DOMAIN_OBJECT_OR_STRING__, __TYPE__, __REASON_OR_NIL__, __COMMENT_OR_NIL__) \
//            FLThrowError([NSError errorWithDomain:__DOMAIN_OBJECT_OR_STRING__ \
//                            code:(__TYPE__) \
//                            localizedDescription:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__) \
//                            userInfo:nil \
//                            reason:__REASON_OR_NIL__ \
//                            comment:__COMMENT_OR_NIL__ \
//                            stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)])


