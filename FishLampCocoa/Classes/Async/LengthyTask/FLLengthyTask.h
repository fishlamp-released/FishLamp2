//
//  FLLengthyTask.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@protocol FLLengthyTaskDelegate;

#import "FLCancellable.h"
#import "FLContextual.h"

@interface FLLengthyTask : FLContextual<FLCancellable> {
@private
    BOOL _wasCancelled;
    BOOL _started;
	NSString* _name;
	NSUInteger _totalStepCount;
	NSUInteger _currentStep;
	__unsafe_unretained id<FLLengthyTaskDelegate> _delegate;
}

+ (id) lengthyTask;

@property (readwrite, strong, nonatomic) NSString* taskName;

@property (readwrite, assign) id<FLLengthyTaskDelegate> delegate;

- (void) executeTask;

// override points.
- (void) prepareTask;
- (NSUInteger) calculateTotalStepCount; // returns totalStepCount

- (BOOL) shouldExecuteTask; // default returns YES
- (void) beginSelf;

@property (readonly, assign, nonatomic) NSUInteger totalStepCount;

@property (readwrite, assign, nonatomic) NSUInteger stepCount;
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