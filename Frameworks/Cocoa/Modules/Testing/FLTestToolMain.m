//
//  FLTestToolMain.m
//  FLCore
//
//  Created by Mike Fullerton on 11/20/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestToolMain.h"
#import "FLUnitTestRunner.h"

#import "FLGcdDispatcher.h"

int FLTestToolMain(int argc, const char *argv[]) {
    @autoreleasepool {
        @try {
            [[FLUnitTestRunner unitTestRunner] runSynchronously];
            return 0;
        }
        @catch(NSException* ex) {
            NSLog(@"uncaught exception: %@", [ex reason]);
            return 1;
        }
        
        return 0;
    }
}
