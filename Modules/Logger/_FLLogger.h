//
//	_FLLogger.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

//#import <execinfo.h>

//#import "NSString+FLCore.h"
// don't want to import NSString+FLCore here.
extern NSString* FLStringWithFormatOrNil(NSString* formatOrNil, ...);

extern void FLShowSynchronized(NSString* string);

typedef void (*FLLoggerOutput)(NSString* string);

typedef NSString* (*FLLoggerLineFormatter)(FLLoggerLevel level, const char* file, int line, NSString* logString);

// logger data structure

#define kFLNumLoggerLevels 3

typedef struct {
    FLLoggerOutput loggerOutput;
    FLLoggerLineFormatter lineFormatter;
    BOOL enabled;
} FLLoggerOutputDescriptor_t;

extern const FLLoggerOutputDescriptor_t FLLoggerOutputDescriptorNone;

typedef struct {
    FLLoggerLevel logLevel;
    FLLoggerOutputDescriptor_t outputDescriptors[kFLNumLoggerLevels];
} FLLogger_t;

// default logger
extern FLLogger_t s_default_app_logger;


#if DEBUG
// default formatters and output

// ignores file and line
extern NSString* FLLoggerDefaultLineFormatter(FLLoggerLevel level, const char* file, int line, NSString* logString);

// adds counter and file and line info
extern NSString* FLLoggerDefaultDebugLineFormatter(FLLoggerLevel level, const char* file, int line, NSString* logString);

// utils

// logger level level of the logger
extern void FLLoggerSetLevel(FLLogger_t* logger, FLLoggerLevel level);
extern FLLoggerLevel FLLoggerGetLevel(FLLogger_t* logger);

// change output of logger by level
extern void FLLoggerSetLoggerOutput(FLLogger_t* logger, FLLoggerLevel level, FLLoggerOutput output);
extern void FLLoggerSetLineFormatter(FLLogger_t* logger, FLLoggerLevel level, FLLoggerLineFormatter formatter);

// get output descriptor
extern void FLLoggerSetOutputDescriptor(FLLogger_t* logger, FLLoggerLevel level, FLLoggerOutputDescriptor_t descriptor);
extern FLLoggerOutputDescriptor_t* FLLoggerGetOutputDescriptor(FLLogger_t* logger, FLLoggerLevel level);

// misc until for line formatters
extern const char* FLFileNameFromFilePath(const char* filePath);

extern void FLLoggerLog(FLLogger_t* logger, FLLoggerLevel level, const char* file, int lineNum, NSString* line);

#else

#import "_FLLoggerInlines.h"

#endif