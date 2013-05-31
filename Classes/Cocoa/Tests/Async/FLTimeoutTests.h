//
//  FLTimeoutTests.h
//  FishLampCoreTests
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUnitTest.h"
#import "FLTimer.h"

@interface FLTimeoutTests : FLUnitTest<FLTimerDelegate> {
@private
    BOOL _didTimeout;
}

@end
