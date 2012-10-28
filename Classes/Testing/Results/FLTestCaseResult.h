//
//  FLTestCaseResult.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTestResult.h"
@class FLTestCase;

@interface FLTestCaseResult : NSObject<FLTestResult> {
@private
    BOOL _didRun;
    BOOL _didPass;
    NSError* _error;
    FLTestCase* _testCase;
}
@property (readonly, strong) FLTestCase* testCase;
@property (readonly, strong, nonatomic) NSError* error;
@end
