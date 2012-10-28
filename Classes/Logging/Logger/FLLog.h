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
#import "FLPrintf.h"
#import "FLLogSink.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

#define NSLog FLCLog

#define FLLogWithType(__TYPE__, __FORMAT__, ...) \
            FLLogStringToSinksWithType(__TYPE__, FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__))

#define FLCLogWithType(__TYPE__, __FORMAT__, ...) \
            FLCLogStringToSinksWithType(__TYPE__, FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__))

#define FLLog(__FORMAT__, ...)   \
           FLLogWithType(FLLogTypeDiagnostic, __FORMAT__, ##__VA_ARGS__)

#define FLCLog(__FORMAT__, ...)   \
            FLCLogWithType(FLLogTypeDiagnostic, __FORMAT__, ##__VA_ARGS__)

#define FLLogError(__FORMAT__, ...) \
           FLLogWithType(FLLogTypeError, __FORMAT__, ##__VA_ARGS__)

#define FLCLogError(__FORMAT__, ...) \
           FLCLogWithType(FLLogTypeError, __FORMAT__, ##__VA_ARGS__)

//#define FLLogStackTrace() \
//            FLLog(@"Stack:\n%@", FLStackTrace_tString(@"  "))

#if DEBUG
//    #define FLDebugFromFile(file, line, __FORMAT__, ...) \
//        [FLLogger logString:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__) logType:FLLogTypeDebug file:file line:line]

    #define FLDebugLog(__FORMAT__, ...) \
               FLLogWithType(FLLogTypeDebug, __FORMAT__, ##__VA_ARGS__)

    #define FLDebugLogIf(__CONDITION__, __FORMAT__, ...) \
                if(__CONDITION__)FLLogWithType(FLLogTypeDebug, __FORMAT__, ##__VA_ARGS__)

//    #define FLCDebugFromFile(file, line, __FORMAT__, ...) \
//        [FLLogger logString:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__) logType:FLLogTypeDebug file:file line:line]

    #define FLCDebugLog(__FORMAT__, ...) \
                FLCLogWithType(FLLogTypeDebug, __FORMAT__, ##__VA_ARGS__)

    #define FLCDebugLogIf(__CONDITION__, __FORMAT__, ...) \
                if(__CONDITION__) FLCLogWithType(FLLogTypeDebug, __FORMAT__, ##__VA_ARGS__)



#else

    #define FLDebugLog(__FORMAT__, ...) 
    #define FLDebugLogIf(__CONDITION__, __FORMAT__, ...)
    #define FLDebugFromFile(file, line, __FORMAT__, ...)

#endif

#define FLLogFileLocation() FLLog(@"%s, file: %s:%d", __PRETTY_FUNCTION__, __FILE__, __LINE__)

#if DEBUG
#define FLTrace(__FORMAT__, ...) DO_PRAGMA(message("FLTrace not defined. #include \"FLTraceOn.h\" or \"FLTraceOff.h\" to enable or disable it."))
#define FLTraceIf(__BOOL__, __FORMAT__, ...) DO_PRAGMA(message("FLTrace not defined. #include \"FLTraceOn.h\" or \"FLTraceOff.h\" to enable or disable it."))
#else 
#define FLTrace(__FORMAT__, ...)
#define FLTraceIf(__BOOL__, __FORMAT__, ...) 
#endif

//#define debugRect(rect) debug(@"%s x:%.4f, y:%.4f, w:%.4f, h%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
//#define debugSize(size) debug(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
//#define debugPoint(point) debug(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)
