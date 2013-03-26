//
//  FLLogger.m
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLogger.h"
#import "FLConsoleLogSink.h"
#import "FLLogPacket_Internal.h"
#import "FLObjcRuntime.h"
#import "FLCancelError.h"

@implementation FLErrorException (FLLogger)

- (void) logExceptionToLogger:(FLLogger*) logger {
    
    NSError* error = self.error;
    if(error) {
        [logger logError:error];
    }
    else {
        [super logExceptionToLogger:logger]; // really [super raiseAndLog]
    }
}

@end

@implementation NSException (FLLogger) 

// this is really "raise"
+ (void)raiseAndLog:(NSString *)name format:(NSString *)format, ... {

    va_list argList;
    va_start(argList, format);
    NSString* comment = FLAutorelease([[NSMutableString alloc] initWithFormat:format arguments:argList]);
    va_end(argList);

    [[FLLogger instance] logString:[NSString stringWithFormat:@"%@: %@", name, comment]
                           logType:FLLogTypeException 
                        stackTrace:FLCreateStackTrace(YES)];

    [self raiseAndLog:name format:format arguments:argList];
}

// this is really "raise"
+ (void)raiseAndLog:(NSString *)name format:(NSString *)format arguments:(va_list)argList {
    NSString* comment = FLAutorelease([[NSMutableString alloc] initWithFormat:format arguments:argList]);

    [[FLLogger instance] logString:[NSString stringWithFormat:@"%@: %@", name, comment]
                           logType:FLLogTypeException 
                        stackTrace:FLCreateStackTrace(YES)];
    
    [self raiseAndLog:name format:format arguments:argList];
}

- (void) logExceptionToLogger:(FLLogger*) logger {
    [logger logException:self];
}

// this is really the new "raise"
- (void) raiseAndLog { 
    [self logExceptionToLogger:[FLLogger instance]];
    [self raiseAndLog]; // call swizzled raise
}

+ (void) swizzleRaiseMethods {
    FLSwizzleInstanceMethod([NSException class], @selector(raise), @selector(raiseAndLog));
    FLSwizzleClassMethod([NSException class], @selector(raise:format:), @selector(raiseAndLog:format:));
    FLSwizzleClassMethod([NSException class], @selector(raise:format:arguments:), @selector(raiseAndLog:format:arguments:));       
}

//+ (void) unswizzleRaiseMethods {
//    FLSwizzleInstanceMethod([NSException class], @selector(raiseAndLog), @selector(raise));
//    FLSwizzleInstanceMethod([NSException class], @selector(raise:format:), @selector(raiseAndLog:format:));
//    FLSwizzleInstanceMethod([NSException class], @selector(raise:format:arguments:),        
//}


@end

void FLLoggerUncaughtExceptionHandler(NSException* ex);
NSUncaughtExceptionHandler* s_previousUncaughtExceptionHandler = nil;


@implementation FLLogger

FLSynthesizeSingleton(FLLogger);

+ (void) initialize {

    static BOOL s_initialized = NO;
    if(!s_initialized) {
        s_initialized = YES;
        s_previousUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
        NSSetUncaughtExceptionHandler(FLLoggerUncaughtExceptionHandler);
        [NSException swizzleRaiseMethods];
    }
}

- (id) init {
    self = [super init];
    if(self) {
        _fifoQueue = dispatch_queue_create("com.fishlamp.logger", DISPATCH_QUEUE_SERIAL);
        _sinks = [[NSMutableArray alloc] init];
#if DEBUG
        [self addLoggerSink:[FLConsoleLogSink consoleLogSink:FLLogOutputSimple|FLLogOutputWithLocation]];
#endif
    }
    
    return self;
}

- (void) dealloc {
    dispatch_release(_fifoQueue);
#if FL_MRC
    [_sinks release];
    [super dealloc];
#endif
}

- (void) pushLoggerSink:(id<FLLogSink>) sink {
    dispatch_async(_fifoQueue, ^{
        [_sinks insertObject:sink atIndex:0];
    });
}

- (void) addLoggerSink:(id<FLLogSink>) sink {
    dispatch_async(_fifoQueue, ^{
        [_sinks addObject:sink];
    });
}

- (void) removeLoggerSink:(id<FLLogSink>) sink {
    dispatch_async(_fifoQueue, ^{
        [_sinks removeObject:sink];
    });
}

//NS_INLINE
//const char* lastPathComponent(const char* str) {
//    const char* ptr = str;
//    while(*str++) {
//        if(*(str-1) == '.') {
//            ptr = str;
//        }
//    }
//    return ptr;
//}

- (void) sendEntryToSinks:(FLLogEntry*) entry {
    BOOL stop = NO;
    for(id<FLLogSink> sink in _sinks) {
        [sink logEntry:entry stop:&stop];
        if(stop) {
            break;
        }
    } 
    [entry releaseToCache];
}

- (void) logEntry:(FLLogEntry*) entry {
    dispatch_async(_fifoQueue, ^{
        [self sendEntryToSinks:entry];
    });
}

- (void) logEntries:(NSArray*) entryArray {
    dispatch_async(_fifoQueue, ^{
        for(FLLogEntry* entry in entryArray) {
            [self sendEntryToSinks:entry];
        }
    });
}

- (void) logError:(NSError*) error {
    dispatch_async(_fifoQueue, ^{
        FLLogEntry* entry = [FLLogEntry logEntry];
        entry.error = error;
        entry.logString = [error localizedDescription];
        entry.stackTrace = error.stackTrace;
        [self sendEntryToSinks:entry];
    });
}

- (void) logException:(NSException*) exception withComment:(NSString*) comment {
    FLLogEntry* entry = [FLLogEntry logEntry];
    entry.exception = exception;
    
    NSString* info = [NSString stringWithFormat:@"name: %@, reason: %@", exception.name, exception.reason];
    
    if(comment) {
        comment = [NSString stringWithFormat:@"%@ (%@)", comment, info];
    }
    else {
        comment = info;
    }
    
    entry.logString = comment;
    entry.stackTrace = [FLStackTrace stackTraceWithException:exception];

    [self sendEntryToSinks:entry];
}

- (void) logException:(NSException*) exception {
    dispatch_async(_fifoQueue, ^{
        [self logException:exception withComment:nil];
    });
}


- (void) logString:(NSString*) string
           logType:(NSString*) logType
        stackTrace:(FLStackTrace*) stackTrace {
 

    if(FLStringIsEmpty(string)) {
        return;
    }

#if DEBUG
    NSCAssert(![string isEqualToString:@"(null)"], @"got null string in logger");
    NSCAssert(string != nil, @"logger line is nil");
    NSCAssert(logType != FLLogTypeInvalid, @"sending in invalid log type");
#endif

    dispatch_async(_fifoQueue, ^{
        FLLogEntry* entry = [FLLogEntry logEntry];
        entry.logString = string;
        entry.logType = logType;
        entry.stackTrace = stackTrace;
        [self sendEntryToSinks:entry];
    });
}

@end

void FLLoggerUncaughtExceptionHandler(NSException *exception) {
    @try {
        [[FLLogger instance] logException:exception withComment:@"Uncaught Exception (app will crash)"];
    }
    @catch(NSException* ex) {
        NSLog(@"logger threw exception in uncaught exception handler (app will now crash).\nException name: %@, reason: %@", ex.name, ex.reason);
    }
    
    if(s_previousUncaughtExceptionHandler) {
        s_previousUncaughtExceptionHandler(exception);
    }
}
