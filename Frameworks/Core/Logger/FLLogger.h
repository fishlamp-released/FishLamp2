//
//  FLLogger.h
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

#import "FLLogEntry.h"

@interface FLLogger : NSObject {
@private
    NSMutableArray* _sinks;
}

FLSingletonProperty(FLLogger);

- (void) pushLoggerSink:(id<FLLogSink>) sink;
- (void) addLoggerSink:(id<FLLogSink>) sink;
- (void) removeLoggerSink:(id<FLLogSink>) sink;

- (void) sendStringToSinks:(NSString*) string
                  logType:(NSString*) logType
               stackTrace:(FLStackTrace*) stackTrace;

- (void) sendEntryToSinks:(FLLogEntry*) entry;
- (void) sendEntriesToSinks:(NSArray*) entryArray;

@end

