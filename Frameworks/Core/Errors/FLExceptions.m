//
//  FLExceptions.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

//#import "FLExceptions.h"
//
//id FLThrowErrorIfNeeded(id object) {
//    if(!object) {
//        return nil;
//    }
//    NSError* error = [object error];
//    if(!error) { 
//        return error;
//    }
//
//    FLThrowException([NSException exceptionWithError:[FLMutableError mutableErrorWithError:error stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]]);
//    
//    return object;
//}
//
//#if DEBUG
//#define __INLINES__ 
//#include "FLExceptions_Inlines.h"
//#undef __INLINES__
//#endif

#import "FLErrorException.h"

NSException* FLDefaultWillThrowExceptionHandler(NSException *exception) {
    return exception;
}

static FLWillThrowExceptionHandler* s_will_throw_exception_handler = nil;

void FLSetWillThrowExceptionHandler(FLWillThrowExceptionHandler handler) {
    s_will_throw_exception_handler = handler;
}

FLWillThrowExceptionHandler* FLGetWillThrowExceptionHandler() {
    return s_will_throw_exception_handler == nil ? FLDefaultWillThrowExceptionHandler : s_will_throw_exception_handler;
}


@implementation NSError (FLExceptionCreation)

- (NSException*) createExceptionWithStackTrace:(FLStackTrace_t) stackTrace userInfo:(NSDictionary*) userInfo {
    self.stackTrace = [FLStackTrace stackTrace:stackTrace];
    NSException* exception = [self createException:userInfo];
    exception.error = self;
    return exception;
}

- (NSException*) createException:(NSDictionary*) userInfo {
    return [FLErrorException exceptionWithName:FLErrorExceptionName reason:self.localizedDescription userInfo:userInfo error:self];
}

@end

