//
//  FLTestResult.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLamp.h"

@protocol FLTestResult <NSObject>
- (BOOL) passed;
- (NSError*) error;
- (NSString*) testName;

@optional
- (NSString*) runSummary;
- (NSString*) failureDescription;
@end

@protocol FLMutableTestResult <FLTestResult>
- (void) setError:(NSError*) error;
- (void) setPassed; // only passes if error is nil
@end

@interface FLTestResult : NSObject<FLMutableTestResult> {
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

+ (id) countedTestResult:(NSUInteger) expectedCount;

@end
