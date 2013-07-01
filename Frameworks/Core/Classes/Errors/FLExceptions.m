//
//  FLExceptions.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLErrorException.h"
#import "FishLampCore.h"

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

- (BOOL) isError {
    return YES;
}

@end

@implementation NSObject (FLException)
- (BOOL) isError {
    return NO;
}
@end

