//
//  NSException+NSError.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NSException* (*FLExceptionHook)(NSException* exception);

@interface NSException (NSError)

@property (readonly, copy, nonatomic) NSError* error;

- (id) initWithName:(NSString*) name
             reason:(NSString*) reason
           userInfo:(NSDictionary*) userInfo
              error:(NSError*)error;
                
+ (NSException*) exceptionWithName:(NSString *)name
                            reason:(NSString *)reason
                          userInfo:(NSDictionary *)userInfo
                             error:(NSError*)error;

+ (NSException*) exceptionWithError:(NSError*)error;

//+ (FLExceptionHook) exceptionHook;
//+ (void) setExceptionHook:(FLExceptionHook) hook;
//
//+ (NSException*) invokeExceptionHook:(NSException*) exception;

@end
    
//@interface NSObject (ThrowingErrors)
//+ (NSException*) willThrowException:(NSException*) exception;
//- (NSException*) willThrowException:(NSException*) exception;
//@end


