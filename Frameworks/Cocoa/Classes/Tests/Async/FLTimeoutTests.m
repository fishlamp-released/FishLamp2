//
//  FLTimeoutTests.m
//  FishLampCoreTests
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTimeoutTests.h"
#import "FLTimer.h"
#import "FLDispatchQueue.h"

@implementation FLTimeoutTests

+ (FLTestGroup*) testGroup {
    return [FLTestGroup sanityCheckTestGroup];
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
