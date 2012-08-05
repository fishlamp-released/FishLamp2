//
//	FLLogger.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"
#import "FLDebug.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

typedef enum {
    FLLoggerLevelHigh,
    FLLoggerLevelMedium,
    FLLoggerLevelLow,
    FLLoggerLevelOff,
    FLLoggerLevelTrace
} FLLoggerLevel;

// implementation stuff is in this file to make FLLogger.h more readable.
#import "_FLLogger.h" 

#define FLLoggerDefault() (&s_default_app_logger)

#define FLLogger(__LEVEL__, __FORMAT__, ...) \
    FLLoggerLog(FLLoggerDefault(), __LEVEL__, __FILE__, __LINE__, FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__))

#define FLLogHigh(__FORMAT__, ...) \
    FLLoggerLog(FLLoggerDefault(), FLLoggerLevelHigh, __FILE__, __LINE__, FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__))

#define FLLog   FLLogHigh

#define FLLogMedium(__FORMAT__, ...) \
    FLLoggerLog(FLLoggerDefault(), FLLoggerLevelMedium, __FILE__, __LINE__, FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__))

#define FLLogLow(__FORMAT__, ...) \
    FLLoggerLog(FLLoggerDefault(), FLLoggerLevelLow, __FILE__, __LINE__, FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__))

#define FLLogWithLevel(__LEVEL__, __FORMAT__, ...) \
    FLLoggerLog(FLLoggerDefault(), __LEVEL__, __FILE__, __LINE__, FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__))

NS_INLINE
void FLLogStackTrace(FLLoggerLevel level) {
    if(FLLoggerDefault()->logLevel >= level) {
        FLLoggerLog(FLLoggerDefault(), level, __FILE__, __LINE__, FLStringWithFormatOrNil(@"Stack:\n%@", FLStackTraceString()));
    }
}

#define FLDebugLogFileLocation() FLDebugLog(@"%s, file: %s, line: %d", __PRETTY_FUNCTION__, __FILE__, __LINE__)
 
#if DEBUG
    #define FLDebugLogFromElsewhere(file, line, __FORMAT__, ...) \
        FLShowSynchronized((__fl_bridge CFTypeRef) FLLoggerDefaultDebugLineFormatter(FLLoggerLevelTrace, file, line, FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)))

    #define FLDebugLog(__FORMAT__, ...) \
        FLShowSynchronized((__fl_bridge CFTypeRef) FLLoggerDefaultDebugLineFormatter(FLLoggerLevelTrace, __FILE__, __LINE__, FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)))
#else

    #define FLDebugLog(__FORMAT__, ...) 
    #define FLDebugLogFromElsewhere(file, line, __FORMAT__, ...)

#endif

extern void FLLoggerExceptionHook(const char* function, const char* file, int line, NSException* exception);

extern void FLConnectLoggerToExceptions();


//#define debugRect(rect) debug(@"%s x:%.4f, y:%.4f, w:%.4f, h%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
//#define debugSize(size) debug(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
//#define debugPoint(point) debug(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

