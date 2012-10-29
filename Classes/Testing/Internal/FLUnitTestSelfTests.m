//
//  FLUnitTestSelfTests.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUnitTestSelfTests.h"

@implementation FLUnitTestSelfTests

@end

@interface FLUnitTestSanityCheck : FLSanityCheck

@end

@implementation FLUnitTestSanityCheck

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (void) testsWillRun {
    [self.results setTestResultForSelector:@selector(basicTest)];
}

- (void) basicTest {
    [[self.results testResultForSelector:_cmd] setPassed];
}

//- (void) basicTestWithFinisher {
////    [s_result addHandledSelector:_cmd];
////    [
////    [finisher setFinished];
//}


@end
