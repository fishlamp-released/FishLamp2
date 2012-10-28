//
//  FLTestCaseResult.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestCaseResult.h"
#import "FLTestCaseResult_Internal.h"

@interface FLTestCaseResult ()
@property (readwrite, strong) FLTestCase* testCase;
@property (readwrite, strong, nonatomic) NSError* error;
@end

@implementation FLTestCaseResult
@synthesize didRun = _didRun;
@synthesize didPass = _didPass;
@synthesize testCase = _testCase;
@synthesize error = _error;

- (id) initWithTestCase:(FLTestCase*) testCase {
    self = [super init];
    if(self) {
        self.testCase = testCase;
        self.error = testCase.error;
//        _didRun = testCase.didRun;

        if(!testCase.error) {
            _didPass = YES;
        }
    }

    return self;
}


+ (FLTestCaseResult*) testCaseResult:(FLTestCase*) test {
    return FLReturnAutoreleased([[[self class] alloc] initWithTestCase:test]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_testCase release];
    [_error release];
    [super dealloc];
}
#endif

- (NSString*) runSummary {
    return nil;
}

- (NSString*) failureDescription {

    return nil;
}

- (NSString*) testName {
    return self.testCase.testCaseName;
}

@end