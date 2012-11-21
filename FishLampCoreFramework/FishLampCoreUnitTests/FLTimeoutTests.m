//
//  FLTimeoutTests.m
//  FishLampCoreTests
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTimeoutTests.h"
#import "FLTimeoutTimer.h"

@implementation FLTimeoutTests

- (void) testTimeout {
    
    FLTimeoutTimer* timer = [FLTimeoutTimer timeoutTimer:1];
    
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    [timer startTimer:nil];

    while(!timer.timedOut && (start + 3.0) > [NSDate timeIntervalSinceReferenceDate]) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
    }

    FLAssert_(timer.timedOut == YES);

}

@end
