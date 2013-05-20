//
//	GtUnitTestManager.h
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if UNIT_TESTS

#import "GtUnitTest.h"
#import "GtUnitTestGroup.h"

@interface GtUnitTestManager : NSObject {
	NSMutableArray* m_tests;
}

- (void) executeTests;
- (void) discoverTests;

- (void) runOnMainThread;

@end
#endif