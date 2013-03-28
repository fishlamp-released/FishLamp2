//
//  FLLogger.h
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"
#import "FLLogEntry.h"
#import "FLLogSink.h"
#import "FLStringFormatter.h"
#import "FLWhitespace.h"

#define FLLogTypeNone       nil
#define FLLogTypeLog        @"com.fishlamp.log"

@class FLLogger;

@interface FLLogger : FLStringFormatter {
@private
    NSMutableArray* _sinks;
    dispatch_queue_t _fifoQueue;
    FLWhitespace* _whitespace;
    NSInteger _indentLevel;
    NSString* _eolString;
}

- (id) initWithWhitespace:(FLWhitespace*) whitespace;
+ (id) loggerWithWhitespace:(FLWhitespace*) whitespace;
+ (id) logger;

- (void) pushLoggerSink:(id<FLLogSink>) sink;
- (void) addLoggerSink:(id<FLLogSink>) sink;
- (void) removeLoggerSink:(id<FLLogSink>) sink;

@end

@interface FLLogger (GrossImplementationMethods)
// for subclasses.
- (void) dispatchBlock:(dispatch_block_t) block;
- (void) logString:(NSString*) string
           logType:(NSString*) logType
        stackTrace:(FLStackTrace*) stackTrace;
- (void) logEntry:(FLLogEntry*) entry;
- (void) logEntries:(NSArray*) entryArray;
- (void) logError:(NSError*) error;
- (void) logException:(NSException*) exception;
- (void) logException:(NSException*) exception withComment:(NSString*) comment;
@end


@interface NSException (FLLogger) 
- (void) logExceptionToLogger:(FLLogger*) logger;
@end


#define FLLogToLogger(__LOGGER_, __TYPE__, __FORMAT__, ...) \
            [__LOGGER_ logString:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__) logType:__TYPE__ stackTrace:FLCreateStackTrace(NO)];

