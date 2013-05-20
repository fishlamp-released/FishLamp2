//
//  FLTestToolMain.m
//  FLCore
//
//  Created by Mike Fullerton on 11/20/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTestToolMain.h"
#import "FLUnitTestRunner.h"

#import "FLAsyncQueue.h"
#import "FLOperation.h"

#import "FLUnitTest.h"
#import "FLAppInfo.h"

int FLTestToolMain(int argc, const char *argv[], NSString* bundleIdentifier, NSString* appName, NSString* version) {
    @autoreleasepool {
        @try {
            [FLAppInfo setAppInfo:bundleIdentifier
                          appName:appName
                          version:version];            
        
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
