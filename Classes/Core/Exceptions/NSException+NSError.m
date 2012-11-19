//
//  NSException.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSException+NSError.h"

//static FLExceptionHook s_exceptionHook = nil;

@implementation NSException (NSError)

FLSynthesizeAssociatedProperty_(retain_nonatomic, _error, setError, NSError*);

- (NSError*) error {
    NSError* error = [self _error];
    if(!error) {
    
    }
    return error;
}

- (id) initWithName:(NSString*) inName
             reason:(NSString*) inReason
           userInfo:(NSDictionary*) inUserInfo
              error:(NSError*)error {

    FLAssertNotNil_(error);

    if(error) {

        if(FLStringIsEmpty(inName)) {
            inName = [NSString stringWithFormat:@"Error: %@:%ld", error.domain, (long) error.code];
        }
        
        if(FLStringIsEmpty(inReason)) {
            inReason = [error localizedDescription];
        }
        
        [self setError:error];
    }
    
    return [self initWithName:inName
                       reason:inReason
                     userInfo:inUserInfo];
}


+ (NSException*) exceptionWithName:(NSString *)name
                            reason:(NSString *)reason
                          userInfo:(NSDictionary *)userInfo
                             error:(NSError*)error {
	return autorelease_([[[self class] alloc] initWithName:name reason:reason userInfo:userInfo error:error]);
}

+ (NSException*) exceptionWithError:(NSError*)error {
	return autorelease_([[[self class] alloc] initWithName:nil reason:nil userInfo:nil error:error]);
}

//+ (FLExceptionHook) exceptionHook {
//    return s_exceptionHook;
//}
//
//+ (void) setExceptionHook:(FLExceptionHook) hook {
//    s_exceptionHook = hook;
//}
//
//+ (void) willThrowException:(NSException*) exception {
//
//    if(s_exceptionHook) {
//        s_exceptionHook(exception);
//    }
//}
//
//+ (NSException*) invokeExceptionHook:(NSException*) exception {
//    if(s_exceptionHook && exception) {
//        return s_exceptionHook(exception);
//    }
//    return exception;
//}

@end

//@implementation NSObject (ThrowingErrors)
//
//+ (NSException*) willThrowException:(NSException*) exception {
//    return [NSException invokeExceptionHook:exception];
//}
//
//- (NSException*) willThrowException:(NSException*) exception {
//    return [[self class] willThrowException:exception];
//}
//@end


