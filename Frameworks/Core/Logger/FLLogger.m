//
//  FLLogger.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLogger.h"
#import "FLPrintfLogSink.h"
#import "FLLogPacket_Internal.h"
#import "FLObjcRuntime.h"

//NSException* FLLoggerExceptionHook(NSException* exception) {
//    
//    [[FLLogger instance] sendStringToSinks:[exception reason]
//                                   logType:FLLogTypeException
//                                stackTrace:exception.error.stackTrace];
//    
//    return exception;
//}
//
//void FLConnectLoggerToExceptions() {
//    [NSException setExceptionHook:FLLoggerExceptionHook];
//}

@implementation NSException (FLLogger)

- (void) raiseAndLog {

    [[FLLogger instance] sendStringToSinks:[self reason]
                                   logType:FLLogTypeException
                                stackTrace:self.error.stackTrace];

// call original method.
    [self raiseAndLog];
}

@end


@implementation FLLogger

FLSynthesizeSingleton(FLLogger);

+ (void) initialize {
    static BOOL s_initialized = NO;
    if(!s_initialized) {
        s_initialized = YES;
        FLSelectorSwizzle([NSException class], @selector(raise), @selector(raiseAndLog));
    }
}

- (id) init {
    self = [super init];
    if(self) {
        _sinks = [[NSMutableArray alloc] init];
#if DEBUG
        [self addLoggerSink:[FLPrintfLogSink logSink:FLLogOutputSimple]];
#endif
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_sinks release];
    [super dealloc];
}
#endif

- (void) pushLoggerSink:(id<FLLogSink>) sink {
    @synchronized(self) {
        [_sinks insertObject:sink atIndex:0];
    }
}

- (void) addLoggerSink:(id<FLLogSink>) sink {
    @synchronized(self) {
        [_sinks addObject:sink];
    }
}

- (void) removeLoggerSink:(id<FLLogSink>) sink {
    @synchronized(self) {
        [_sinks removeObject:sink];
    }
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

- (void) _sendEntryToSinks:(FLLogEntry*) entry {
    BOOL stop = NO;
    for(id<FLLogSink> sink in _sinks) {
        [sink appendLogEntry:entry stop:&stop];
        if(stop) {
            break;
        }
    } 
}

- (void) sendEntryToSinks:(FLLogEntry*) entry {
    @synchronized(self) {
        [self _sendEntryToSinks:entry];
    }
}

- (void) sendEntriesToSinks:(NSArray*) entryArray {
    @synchronized(self) {
        for(FLLogEntry* entry in entryArray) {
            [self _sendEntryToSinks:entry];
        }
    }
}

- (void) sendStringToSinks:(NSString*) string
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

    @synchronized(self) {
        static uint32_t s_counter = 0;
        FLLogEntry* entry = [FLLogEntry logEntry];
        [entry preparePacketForDelivery:string forLogType:logType forLogName:@"log" stackTrace:stackTrace logCount:s_counter++];
        [self _sendEntryToSinks:entry];
    }
}

@end
