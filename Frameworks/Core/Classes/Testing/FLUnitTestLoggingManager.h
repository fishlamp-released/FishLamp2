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


@interface FLUnitTestLoggingManager: NSObject {
@private
    NSMutableArray* _loggers;
    NSMutableArray* _stateStack;
}

FLSingletonProperty(FLUnitTestLoggingManager);

- (void) addLogger:(id<FLStringFormatter>) formatter forLogLevel:(FLUnitTestLogLevel) logLevel;
- (void) pushLogger:(id<FLStringFormatter>) formatter forLogLevel:(FLUnitTestLogLevel) logLevel;
- (void) popLogger;

- (void) pushLogLevel:(FLUnitTestLogLevel) level;
- (void) popLogLevel;

- (void) logInLevelBlock:(FLUnitTestLogLevel) level block:(void (^)()) block;

- (id<FLStringBuilder>) logger;

@end

//@protocol FLUnitTestLoggingContext <NSObject>
//
//- (BOOL) loggingManagerShouldPropagate:(FLUnitTestLoggingManager*) manager;
//
//@end

//#ifndef FLTestLog
//#define FLTestLog NSLog
//#endif

//#ifndef FLTestLog
//#define FLTestLog(__FORMAT__, ...) [self.logger appendLine:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)]
//#endif

#define FLTestLog [[FLUnitTestLoggingManager instance] logger]