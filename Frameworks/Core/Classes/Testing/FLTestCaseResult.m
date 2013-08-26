//
//  FLTestCaseResult.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTestCaseResult.h"

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
        _logEntries = [[NSMutableArray alloc] init];
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

- (NSString*) testName {
    return self.testCase.testCaseName;
}

- (FLLogSinkOutputFlags) sinkOutputFlags {
    return FLLogOutputWithLocation | FLLogOutputWithStackTrace;
}

- (void) logEntry:(FLLogEntry*) entry stopPropagating:(BOOL*) stop {

    [_logEntries addObject:FLCopyWithAutorelease(entry)];
    
    *stop = YES;
}

@end