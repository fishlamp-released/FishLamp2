//
//  FLTestToolMain.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/20/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestToolMain.h"
#import "FLUnitTestRunner.h"

int FLTestToolMain(int argc, char *argv[]) {
    @autoreleasepool {
        @try {
            [[FLUnitTestRunner create] runAllTests];
            return 0;
        }
        @catch(NSException* ex) {
            NSLog(@"uncaught exception: %@", [ex reason]);
            return 1;
        }
        
        return 0;
    }
}
