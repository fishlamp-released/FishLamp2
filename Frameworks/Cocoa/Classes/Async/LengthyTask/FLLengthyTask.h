//
//  FLLengthyTask.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLOperation.h"

@protocol FLLengthyTaskDelegate;


@interface FLLengthyTask : FLOperation {
@private
    BOOL _started;
	NSString* _name;
	NSUInteger _totalStepCount;
	NSUInteger _currentStep;
}

+ (id) lengthyTask;

@property (readwrite, strong, nonatomic) NSString* taskName;
@property (readonly, assign, nonatomic) NSUInteger totalStepCount;
@property (readwrite, assign, nonatomic) NSUInteger stepCount;

// override points.
- (void) prepareTask;
- (NSUInteger) calculateTotalStepCount; // returns totalStepCount

- (BOOL) shouldExecuteTask; // default returns YES
- (void) executeSelf;

- (void) setStepCount:(NSUInteger) stepCount
       totalStepCount:(NSUInteger) totalStepCount;

- (void) incrementStep; // same as task.stepCount++

@end

@protocol FLLengthyTaskDelegate <NSObject>
- (BOOL) lengthyTaskShouldBegin:(FLLengthyTask*) task;
- (void) lengthyTaskWillBegin:(FLLengthyTask*) task;
- (void) lengthyTaskDidIncrementStep:(FLLengthyTask*) task;
- (void) lengthyTaskDidChangeName:(FLLengthyTask*) task;
- (void) lengthyTaskDidFinish:(FLLengthyTask*) task;

@end