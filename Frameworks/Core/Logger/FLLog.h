//
//	FLLogger.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#import "FLRequired.h"
#import "FLPrintf.h"
#import "FLLogSink.h"
#import "FLLogger.h"

#define FLLogTypeTrace      @"com.fishlamp.trace"
#define FLLogTypeDebug      @"com.fishlamp.debug"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.
#define FLLog(__FORMAT__, ...)   \
            FLLogToLogger([FLLogLogger instance], FLLogTypeLog, __FORMAT__, ##__VA_ARGS__)

#define FLLogError(__FORMAT__, ...) \
            FLLogToLogger([FLLogLogger instance], FLLogTypeError, __FORMAT__, ##__VA_ARGS__)

#if DEBUG
#define FLDebugLog(__FORMAT__, ...) \
            FLLogToLogger([FLLogLogger instance], FLLogTypeDebug, __FORMAT__, ##__VA_ARGS__)

#define FLDebugLogIf(__CONDITION__, __FORMAT__, ...) \
            if(__CONDITION__) FLDebugLog(__FORMAT__, ##__VA_ARGS__)

#define FLTrace(__FORMAT__, ...) \
            FLLogToLogger([FLLogLogger instance], FLLogTypeTrace, __FORMAT__, ##__VA_ARGS__)

#define FLTraceIf(__CONDITION__, __FORMAT__, ...) \
            if(__CONDITION__) FLTrace(__FORMAT__, ##__VA_ARGS__)


#else

#define FLDebugLog(__FORMAT__, ...) 
#define FLDebugLogIf(__CONDITION__, __FORMAT__, ...)
#define FLDebugFromFile(file, line, __FORMAT__, ...)
#define FLTrace(__FORMAT__, ...)
#define FLTraceIf(__CONDITION__, __FORMAT__, ...)
#endif

#define FLLogFileLocation() \
            FLLog(@"%s, file: %s:%d", __PRETTY_FUNCTION__, __FILE__, __LINE__)

#ifndef FL_DIVERT_NSLOG
#define FL_DIVERT_NSLOG 0
#endif

#if FL_DIVERT_NSLOG
#define NSLog FLLog
#endif

@interface FLLogLogger : FLLogger
FLSingletonProperty(FLLogLogger);
@end


