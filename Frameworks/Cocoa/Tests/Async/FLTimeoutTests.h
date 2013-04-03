//
//  FLTimeoutTests.h
//  FishLampCoreTests
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUnitTest.h"
#import "FLTimer.h"

@interface FLTimeoutTests : FLUnitTest<FLTimerDelegate> {
@private
    BOOL _didTimeout;
}

@end
