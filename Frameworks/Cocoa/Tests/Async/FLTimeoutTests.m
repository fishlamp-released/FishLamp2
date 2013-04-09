//
//  FLTimeoutTests.m
//  FishLampCoreTests
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTimeoutTests.h"
#import "FLTimer.h"

@implementation FLTimeoutTests

+ (FLUnitTestGroup*) unitTestGroup {
    return [self sanityCheckTestGroup];
}

- (void) timerDidTimeout:(FLTimer *)timer {
    _didTimeout = YES;
}

- (void) testTimeout {
    
    _didTimeout = NO;
    
    FLTimer* timer = [FLTimer timer:1];
    timer.delegate = self;
    [timer startTimer];

#if __MAC_10_8
    [FLDispatchQueue sleepForTimeInterval:2];
#endif
    
    FLAssert(timer.timedOut == YES);
    FLAssert(_didTimeout == YES);
}

@end
