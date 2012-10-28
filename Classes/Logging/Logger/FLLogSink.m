//
//  FLLogSink.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLogSink.h"

#if DEBUG
#define LEVEL FLLoggerLevelLow
#else 
#define LEVEL FLLoggerLevelHigh
#endif

NSException* FLLoggerExceptionHook(NSException* exception, id fromObject) {
    
    [FLLogger logStringToSinks:[exception reason]
                       logType:FLLogTypeException
                    stackTrace:exception.error.stackTrace
                    fromObject:fromObject];
    
    return exception;
}

void FLConnectLoggerToExceptions() {
    [NSException setExceptionHook:FLLoggerExceptionHook];
}

@implementation FLLogSink

- (id) initWithLogSinkOutputFlags:(FLLogSinkOutputFlags) outputFlags {
    self = [super init];
    if(self) {
        _outputFlags = outputFlags;
    }
    
    return self;
}

+ (FLLogSink*) logSink:(FLLogSinkOutputFlags) outputFlags {
    return FLReturnAutoreleased([[[self class] alloc] initWithLogSinkOutputFlags:outputFlags]);
}

- (void) openEntry {
}

- (void) logEntryLine:(NSString*) line {
}

- (void) closeEntry {
}

- (void) logString:(NSString*) string
           logInfo:(FLLogInfo) logInfo
          stackTrace:(FLStackTrace*) stackTrace  {
    
    [self openEntry];
    
    char spaces[128];
    char* sptr = spaces;
    
    const char* ptr = logInfo.logName;
    while(*ptr++) {
        *sptr++ = ' ';
    }
    for(int i = 0; i < 3; i++) {
        *sptr++ = ' ';
    }
    *sptr = 0;
    
//    [self logEntryLine:[NSString stringWithFormat:@"%s: \"%@\"", logInfo.logName, string ]];
    [self logEntryLine:string];

    if(FLTestAnyBit(_outputFlags, FLLogOutputWithLocation | FLLogOutputWithStackTrace)) {
        [self logEntryLine:[NSString stringWithFormat:@"%s%s:%d, %s", spaces, stackTrace.fileName, stackTrace.lineNumber, stackTrace.function]];
    }
    if(FLTestBits(_outputFlags, FLLogOutputWithStackTrace)) {
        if(stackTrace.callStack.depth) {
            for(int i = 0; i < stackTrace.callStack.depth; i++) {
                [self logEntryLine:[NSString stringWithFormat:@"%s%s", spaces, [stackTrace stackEntryAtIndex:i]]];
            }
        }
    }
    
    [self closeEntry];
}

@end

@implementation FLLogger

static NSMutableDictionary* s_sinks = nil;

+ (void) initialize {
    if(!s_sinks) {
        s_sinks = [[NSMutableDictionary alloc] init];
    
#if DEBUG
        [self addLoggerSink:[FLPrintfLogSink logSink:FLLogOutputSimple] forLogType:FLLogTypeDiagnostic];
        [self addLoggerSink:[FLPrintfLogSink logSink:FLLogOutputWithLocation] forLogType:FLLogTypeDebug];
        [self addLoggerSink:[FLPrintfLogSink logSink:FLLogOutputWithLocation] forLogType:FLLogTypeTest];
        [self addLoggerSink:[FLPrintfLogSink logSink:FLLogOutputWithLocation] forLogType:FLLogTypeTrace];
        [self addLoggerSink:[FLPrintfLogSink logSink:FLLogOutputWithStackTrace] forLogType:FLLogTypeError];
        [self addLoggerSink:[FLPrintfLogSink logSink:FLLogOutputWithStackTrace] forLogType:FLLogTypeException];
#endif
        FLConnectLoggerToExceptions();
    }
}

+ (void) addLoggerSink:(id<FLLogSink>) sink
            forLogType:(const char*) logType {

    @synchronized(self) {
        id key = [NSValue valueWithPointer:logType];
        NSMutableArray* sinks = [s_sinks objectForKey:key];
        if(!sinks) {
            sinks = [NSMutableArray array];
            [s_sinks setObject:sinks forKey:key];
        }
    
        [sinks addObject:sink];
    }
}

+ (void) removeLoggerSink:(id<FLLogSink>) sink forLogType:(const char*) logType {

    @synchronized(self) {
        NSMutableArray* sinks = [s_sinks objectForKey:[NSValue valueWithPointer:logType]];
        if(sinks) {
            [sinks removeObject:sink];
        }
    }
}

+ (void) logString:(NSString*) string
           logInfo:(FLLogInfo) logInfo
           stackTrace:(FLStackTrace*) stackTrace {

    NSMutableArray* sinks = [s_sinks objectForKey:[NSValue valueWithPointer:logInfo.logType]];
    for(id<FLLogSink> sink in sinks) {
        [sink logString:string logInfo:logInfo stackTrace:stackTrace];
    }
}

NS_INLINE
const char* lastPathComponent(const char* str) {
    const char* ptr = str;
    while(*str++) {
        if(*(str-1) == '.') {
            ptr = str;
        }
    }
    return ptr;
}

+ (void) logStringToSinks:(NSString*) string
                  logType:(const char*) logType
                 stackTrace:(FLStackTrace*) stackTrace
                 fromObject:(id) fromObject {
 
    @synchronized(self) {

        if(FLStringIsEmpty(string)) {
            return;
        }
    
#if DEBUG
        NSCAssert(![string isEqualToString:@"(null)"], @"got null string in logger");
        NSCAssert(string != nil, @"logger line is nil");
        NSCAssert(logType != FLLogTypeInvalid, @"sending in invalid log type");
#endif
        
        static NSUInteger s_count = 0;
        FLLogInfo logInfo = {
            logType,
            lastPathComponent(logType),
            s_count++,
            [NSDate timeIntervalSinceReferenceDate]
        };

        if(fromObject) {
            [fromObject logString:string logInfo:logInfo stackTrace:stackTrace];
        }
        else {
            [self logString:string logInfo:logInfo stackTrace:stackTrace];
        }
    }
}


@end

@implementation NSObject (FLLogger)

- (void) logString:(NSString*) string
           logInfo:(FLLogInfo) logInfo
           stackTrace:(FLStackTrace*) stackTrace {
    [[self class] logString:string logInfo:logInfo stackTrace:stackTrace];
}

+ (void) logString:(NSString*) string
           logInfo:(FLLogInfo) logInfo
           stackTrace:(FLStackTrace*) stackTrace {
    [FLLogger logString:string logInfo:logInfo stackTrace:stackTrace];
}

@end

@implementation FLPrintfLogSink


- (id) init {
    self = [super init];
    if(self) {
        FLPrintf(@"\n");
    }
    return self;
}

- (void) logEntryLine:(NSString*) line {
    FLPrintf(@"%@\n", line);
}
@end


