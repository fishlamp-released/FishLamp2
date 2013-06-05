//
//  FLTestResult.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLAsyncResult.h"

@protocol FLTestResult <NSObject>
@property (readonly, assign) BOOL passed;
@property (readonly, strong) NSError* error;
@property (readonly, strong) NSString* testName;
@optional

- (NSString*) runSummary;
- (NSString*) failureDescription;
@end

@protocol FLMutableTestResult <NSObject>
@property (readwrite, strong) NSError* error;
- (void) setPassed; // only passes if error is nil
@end

@interface FLTestResult : NSObject<FLTestResult, FLMutableTestResult> {
@private 
    NSUInteger _expectedCount;
    NSUInteger _count;
    NSError* _error;
    NSString* _testName;
}

+ (id) testResult;

@end

@interface FLCountedTestResult : FLTestResult

@property (readonly, assign) NSUInteger expectedCount;
@property (readonly, assign) NSUInteger count;

+ (FLCountedTestResult*) countedTestResult:(NSUInteger) expectedCount;

@end
