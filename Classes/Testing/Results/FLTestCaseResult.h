//
//  FLTestCaseResult.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTestResult.h"

@interface FLTestCaseResult : FLTestResult {
@private
    FLTestCase* _testCase;
}
+ (FLTestCaseResult*) testCaseResult:(FLTestCase*) forTest;

@property (readonly, strong) FLTestCase* testCase;
@end

