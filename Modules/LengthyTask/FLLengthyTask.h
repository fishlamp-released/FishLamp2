//
//  FLLengthyTask.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

@protocol FLLengthyTaskDelegate;

#import "FLCancellableOperation.h"

@interface FLLengthyTask : FLCancellableOperation {
@private
	NSString* _name;
	NSUInteger _totalStepCount;
	NSUInteger _currentStep;
	__unsafe_unretained id<FLLengthyTaskDelegate> _delegate;
}

+ (id) lengthyTask;


@property (readonly, assign, nonatomic) NSUInteger totalStepCount;
@property (readonly, assign, nonatomic) NSUInteger currentStep;

@property (readwrite, retain, nonatomic) NSString* taskName;

@property (readwrite, assign, nonatomic) id<FLLengthyTaskDelegate> delegate;

- (void) prepareTask;
- (void) executeTask;

// override points.
- (NSUInteger) calculateTotalStepCount; // returns totalStepCount

- (BOOL) shouldExecuteTask; // default returns YES
- (void) doExecuteTask;

// call these from task when incrementing step
- (void) incrementStep; 

@end

@protocol FLLengthyTaskDelegate <NSObject>
- (BOOL) lengthyTaskShouldBegin:(FLLengthyTask*) task;
- (void) lengthyTaskWillBegin:(FLLengthyTask*) task;
- (void) lengthyTaskDidIncrementStep:(FLLengthyTask*) task;
- (void) lengthyTaskDidChangeName:(FLLengthyTask*) task;
@end