//
//  FLUnitTestLoggingManager.h
//  FishLampCore
//
//  Created by Mike Fullerton on 8/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreRequired.h"
#import "FLUnitTestDefines.h"
#import "FLStringFormatter.h"
#import "FLLogger.h"

@interface FLUnitTestLoggingManager: FLLogger {
@private
    NSMutableArray* _loggers;
}

FLSingletonProperty(FLUnitTestLoggingManager);

- (void) addLogger:(id<FLStringFormatter>) formatter;
- (void) pushLogger:(id<FLStringFormatter>) formatter;
- (void) popLogger;

@end

//@protocol FLUnitTestLoggingContext <NSObject>
//
//- (BOOL) loggingManagerShouldPropagate:(FLUnitTestLoggingManager*) manager;
//
//@end

//#ifndef FLTestOutput
//#define FLTestOutput NSLog
//#endif

//#ifndef FLTestOutput
//#define FLTestOutput(__FORMAT__, ...) [self.logger appendLine:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)]
//#endif

//#define FLTestOutput(__FORMAT__, ...) \
//            [[FLUnitTestLoggingManager instance] appendLineWithFormat:__FORMAT__, ##__VA_ARGS__]

#define FLTestOutput [FLUnitTestLoggingManager instance]
