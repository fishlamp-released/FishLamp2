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
        [self.verifier addExpectedSelector:@selector(basicTest)];
    }
    return self;
}

- (void) basicTest {
    [self.verifier addHandledSelector:_cmd];
}

//- (void) basicTestWithFinisher {
////    [s_result addHandledSelector:_cmd];
////    [
////    [finisher setFinished];
//}


@end
