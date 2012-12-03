//
//  FLUnitTestSelfTests.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUnitTestSelfTests.h"


@implementation FLUnitTestSanityCheck

- (void) setupTests {
    [self.results setTestResultForNumber:1];
}

- (void) basicTest {
    [[self.results testResultForNumber:1] setPassed];
}

@end
