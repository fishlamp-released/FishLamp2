//
//	FLLog.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLLogger.h"
#import <execinfo.h>
#import <stdio.h>
#import <libkern/OSAtomic.h>
#import "FLExceptions.h"

#if DEBUG
#include "_FLLoggerInlines.h"
#endif

const FLLoggerOutputDescriptor_t FLLoggerOutputDescriptorNone = { 0, 0, NO };

#if DEBUG
#define LEVEL FLLoggerLevelLow
#else 
#define LEVEL FLLoggerLevelHigh
#endif


@implementation NSObject (_OutputLockHack) 

+ (void) _callCFShowSynchronized:(NSString*) logString {
    @synchronized(self) {
        CFShow((__fl_bridge CFStringRef) logString);
    }
}

@end

// TODO: hack. Find a better way to do this.

// see OSSpinLockTry maybe
void FLShowSynchronized(NSString* logString) {
    [NSObject _callCFShowSynchronized:logString];
}

FLLogger_t s_default_app_logger = { LEVEL,  {   { FLShowSynchronized, FLLoggerDefaultLineFormatter, YES}, 
                                                { FLShowSynchronized, FLLoggerDefaultLineFormatter, YES}, 
                                                { FLShowSynchronized, FLLoggerDefaultLineFormatter, YES}}}; 

const char* FLFileNameFromFilePath(const char* file){
    const char* fileName = file;
    
    if(!fileName) {
        fileName = "?";
    } else {
        fileName = file + strlen(file);
        while(fileName > file) {
            if(*(fileName-1) == '/') {
                break;
            } 
            --fileName;
        }
    }

    return fileName;
}

NSString* FLLoggerDefaultDebugLineFormatter(FLLoggerLevel level, const char* file, int line, NSString* logString) {
    if(logString) {
        static unsigned int s_logCount = 0;
        return [NSString stringWithFormat:@"#%.4d @[%s:%d]: %@", s_logCount++, FLFileNameFromFilePath(file), line, logString];
    } 
    return @"";
}

void FLLoggerExceptionHook(const char* function, const char* file, int line, NSException* exception) {
    if(FLLoggerGetLevel(FLLoggerDefault()) >= FLLoggerLevelMedium) {
        FLLogStackTrace(FLLoggerLevelMedium);
        FLLogger(FLLoggerLevelMedium, @"Exception [%@:%@:%d]: %@", 
            [NSString stringWithUTF8String:function],
            [NSString stringWithUTF8String:file],
            line,
            [exception description]
            ); 
    }
}

void FLConnectLoggerToExceptions() {
    FLSetExceptionHook(FLLoggerExceptionHook);
}









