//
//  FLTestLoggingManager.h
//  FishLampCore
//
//  Created by Mike Fullerton on 8/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreRequired.h"
#import "FLStringFormatter.h"
#import "FLLogger.h"

@interface FLTestLoggingManager: FLLogger {
@private
    NSMutableArray* _loggers;
}

FLSingletonProperty(FLTestLoggingManager);

- (void) addLogger:(id<FLStringFormatter>) formatter;
- (void) pushLogger:(id<FLStringFormatter>) formatter;
- (void) popLogger;

@end

#define FLTestOutput [FLTestLoggingManager instance]
#define FLTestLog(__FORMAT__, ...) [[FLTestLoggingManager instance] appendLineWithFormat:__FORMAT__, ##__VA_ARGS__]