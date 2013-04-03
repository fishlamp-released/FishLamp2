//
//  FLTestToolMain.m
//  FLCore
//
//  Created by Mike Fullerton on 11/20/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestToolMain.h"
#import "FLUnitTestRunner.h"

#import "FLAsyncQueue.h"
#import "FLOperation.h"

#import "FLUnitTest.h"

int FLTestToolMain(int argc, const char *argv[]) {
    @autoreleasepool {
        @try {
        
            FLLogger* logger = [FLLogger logger];
            [logger addLoggerSink:[FLConsoleLogSink consoleLogSink:FLLogOutputSimple]];
            [FLUnitTest setOutputLog:logger];
        
            FLUnitTestRunner* runner = [FLUnitTestRunner unitTestRunner];
            [runner runSynchronously];
            return 0;
        }
        @catch(NSException* ex) {
            NSLog(@"uncaught exception: %@", [ex reason]);
            return 1;
        }
        
        return 0;
    }
}
