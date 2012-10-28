//
//  FLLogSink.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>


#define FLLogTypeInvalid    nil
#define FLLogTypeDiagnostic "com.fishlamp.diagnostic"
#define FLLogTypeTrace      "com.fishlamp.trace"
#define FLLogTypeDebug      "com.fishlamp.debug"
#define FLLogTypeError      "com.fishlamp.error"
#define FLLogTypeTest       "com.fishlamp.unit-test"
#define FLLogTypeDatabase   "com.fishlamp.database"
#define FLLogTypeException  "com.fishlamp.exception"

typedef const char* FLLogType;

typedef struct {
    const char* logType;
    const char* logName;
    NSUInteger logCount;
    NSTimeInterval timestamp;
} FLLogInfo;

@interface NSObject (FLLogger)

- (void) logString:(NSString*) string
           logInfo:(FLLogInfo) logInfo
           stackTrace:(FLStackTrace*) stackTrace;

+ (void) logString:(NSString*) string
           logInfo:(FLLogInfo) logInfo
           stackTrace:(FLStackTrace*) stackTrace;

@end

@protocol FLLogSink <NSObject>

- (void) logString:(NSString*) string
           logInfo:(FLLogInfo) logInfo
          stackTrace:(FLStackTrace*) stackTrace;
@end

typedef enum {
    FLLogOutputSimple           = 0,
    FLLogOutputWithLocation     = (1 << 1),
    FLLogOutputWithStackTrace   = (1 << 2)
} FLLogSinkOutputFlags;

@interface FLLogSink : NSObject<FLLogSink> {
@private
    FLLogSinkOutputFlags _outputFlags;
}
+ (FLLogSink*) logSink:(FLLogSinkOutputFlags) output;

- (void) openEntry;
- (void) logEntryLine:(NSString*) line;
- (void) closeEntry;

@end

@interface FLPrintfLogSink : FLLogSink {
}
@end

@interface FLLogger : NSObject 

+ (void) addLoggerSink:(id<FLLogSink>) sink forLogType:(const char*) logType;
+ (void) removeLoggerSink:(id<FLLogSink>) sink  forLogType:(const char*) logType;

+ (void) logStringToSinks:(NSString*) string
                  logType:(const char*) logType
                 stackTrace:(FLStackTrace*) stackTrace
               fromObject:(id) objectOrNil;

@end


#define FLLogStringToSinksWithType(__LOG_TYPE__, __STR__) \
            [FLLogger logStringToSinks:__STR__ logType:__LOG_TYPE__ stackTrace:FLCreateStackTrace(NO) fromObject:self];

#define FLCLogStringToSinksWithType(__LOG_TYPE__, __STR__) \
            [FLLogger logStringToSinks:__STR__ logType:__LOG_TYPE__ stackTrace:FLCreateStackTrace(NO) fromObject:nil];

