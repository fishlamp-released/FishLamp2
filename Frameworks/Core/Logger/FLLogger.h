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

#define FLLogTypeInvalid    nil
#define FLLogTypeLog        @"com.fishlamp.log"
#define FLLogTypeTrace      @"com.fishlamp.trace"
#define FLLogTypeDebug      @"com.fishlamp.debug"
#define FLLogTypeError      @"com.fishlamp.error"
#define FLLogTypeException  @"com.fishlamp.exception"

@interface FLLogger : NSObject {
@private
    NSMutableArray* _sinks;
    dispatch_queue_t _fifoQueue;
}

FLSingletonProperty(FLLogger);

- (void) pushLoggerSink:(id<FLLogSink>) sink;
- (void) addLoggerSink:(id<FLLogSink>) sink;
- (void) removeLoggerSink:(id<FLLogSink>) sink;

- (void) logString:(NSString*) string
           logType:(NSString*) logType
        stackTrace:(FLStackTrace*) stackTrace;

- (void) logError:(NSError*) error;
- (void) logException:(NSException*) exception;
- (void) logException:(NSException*) exception withComment:(NSString*) comment;
- (void) logEntry:(FLLogEntry*) entry;
- (void) logEntries:(NSArray*) entryArray;

@end

@interface NSException (FLLogger) 
- (void) logExceptionToLogger:(FLLogger*) logger;
@end
