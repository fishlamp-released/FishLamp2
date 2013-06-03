//
//  FLTestCaseResult.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLTestResult.h"
#import "FLLogSink.h"
#import "FLTestCase.h"

@interface FLTestCaseResult : FLTestResult<FLLogSink> {
@private
    FLTestCase* _testCase;
    NSMutableArray* _logEntries;
}

+ (FLTestCaseResult*) testCaseResult:(FLTestCase*) forTest;

@property (readonly, strong) FLTestCase* testCase;
@property (readonly, strong) NSArray* logEntries;

@end

