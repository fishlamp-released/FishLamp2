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
@end

@implementation FLTestCaseResult
@synthesize testCase = _testCase;
@synthesize logEntries = _logEntries;

- (id) initWithTestCase:(FLTestCase*) testCase {
    self = [super init];
    if(self) {
        self.testCase = testCase;
    }

    return self;
}


+ (FLTestCaseResult*) testCaseResult:(FLTestCase*) test {
    return FLAutorelease([[[self class] alloc] initWithTestCase:test]);
}

#if FL_MRC
- (void) dealloc {
    [_logEntries release];
    [_testCase release];
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

- (void) appendLogEntry:(FLLogEntry*) entry
                   stop:(BOOL*) stop {

    if(!_logEntries) {
        _logEntries = [[NSMutableArray alloc] init];
    }
    
    [_logEntries addObject:entry];
    
    *stop = YES;
}

@end