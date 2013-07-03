//
//	FLLog.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLog.h"
#import <execinfo.h>
#import <stdio.h>
#import <libkern/OSAtomic.h>
#import "FLErrorException.h"
#import "FLExceptions.h"
#import "FLMutableError.h"
#import "FLConsoleLogSink.h"
#import "FLObjcRuntime.h"

#import "FishLampCore.h"


@implementation NSException (FLLogLogger) 

//// this is really "raise"
//+ (void)raiseAndLog:(NSString *)name format:(NSString *)format, ... {
//
//    va_list argList;
//    va_start(argList, format);
//    NSString* comment = FLAutorelease([[NSMutableString alloc] initWithFormat:format arguments:argList]);
//    va_end(argList);
//
//    [[FLLogLogger instance] logString:[NSString stringWithFormat:@"%@: %@", name, comment]
//                           logType:FLLogTypeException 
//                        stackTrace:FLCreateStackTrace(YES)];
//
//    [self raiseAndLog:name format:format arguments:argList];
//}
//
//// this is really "raise"
//+ (void)raiseAndLog:(NSString *)name format:(NSString *)format arguments:(va_list)argList {
//    NSString* comment = FLAutorelease([[NSMutableString alloc] initWithFormat:format arguments:argList]);
//
//    [[FLLogLogger instance] logString:[NSString stringWithFormat:@"%@: %@", name, comment]
//                           logType:FLLogTypeException 
//                        stackTrace:FLCreateStackTrace(YES)];
//    
//    [self raiseAndLog:name format:format arguments:argList];
//}


//// this is really the new "raise"
//- (void) raiseAndLog { 
//    [self logExceptionToLogger:[FLLogLogger instance]];
//    [self raiseAndLog]; // call swizzled raise
//}
//
//+ (void) swizzleRaiseMethods {
//    FLSwizzleInstanceMethod([NSException class], @selector(raise), @selector(raiseAndLog));
//    FLSwizzleClassMethod([NSException class], @selector(raise:format:), @selector(raiseAndLog:format:));
//    FLSwizzleClassMethod([NSException class], @selector(raise:format:arguments:), @selector(raiseAndLog:format:arguments:));       
//}

//+ (void) unswizzleRaiseMethods {
//    FLSwizzleInstanceMethod([NSException class], @selector(raiseAndLog), @selector(raise));
//    FLSwizzleInstanceMethod([NSException class], @selector(raise:format:), @selector(raiseAndLog:format:));
//    FLSwizzleInstanceMethod([NSException class], @selector(raise:format:arguments:),        
//}


@end

void FLLoggerUncaughtExceptionHandler(NSException* ex);
NSUncaughtExceptionHandler* s_previousUncaughtExceptionHandler = nil;

NSException* FLWillThrowExceptionHandlerForLogger(NSException *exception) {

    [[FLLogLogger instance] logException:exception];

//    FLStackTrace* stackTrace = exception.error.stackTrace;
//
//    [[FLLogLogger instance] logString:[NSString stringWithFormat:@"%@: %@", exception.name, exception.reason]
//                           logType:FLLogTypeException 
//                        stackTrace:stackTrace];

    return exception;

}


@implementation FLLogLogger 

FLSynthesizeSingleton(FLLogLogger);

+ (void) initialize {

    static BOOL s_initialized = NO;
    if(!s_initialized) {
        s_initialized = YES;
//        s_previousUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
//        NSSetUncaughtExceptionHandler(FLLoggerUncaughtExceptionHandler);
//        [NSException swizzleRaiseMethods];


        FLSetWillThrowExceptionHandler(FLWillThrowExceptionHandlerForLogger);
    }
}

- (id) init {
    self = [super init];
    if(self) {
        [self addLoggerSink:[FLConsoleLogSink consoleLogSink:FLLogOutputSimple|FLLogOutputWithLocation]];
    }
    
    return self;
}

@end

void FLLoggerUncaughtExceptionHandler(NSException *exception) {
    @try {
        [[FLLogLogger instance] logException:exception withComment:@"Uncaught Exception (app will crash)"];
    }
    @catch(NSException* ex) {
        NSLog(@"logger threw exception in uncaught exception handler (app will now crash).\nException name: %@, reason: %@", ex.name, ex.reason);
    }
    
    if(s_previousUncaughtExceptionHandler) {
        s_previousUncaughtExceptionHandler(exception);
    }
}

