//
//  GtLengthyTask.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol GtLengthyTaskDelegate;

#import "GtCancellableOperation.h"

@interface GtLengthyTask : GtCancellableOperation {
@private
	NSString* m_name;
	NSUInteger m_totalStepCount;
	NSUInteger m_currentStep;
	id<GtLengthyTaskDelegate> m_delegate;
}

+ (id) lengthyTask;


@property (readonly, assign, nonatomic) NSUInteger totalStepCount;
@property (readonly, assign, nonatomic) NSUInteger currentStep;

@property (readwrite, retain, nonatomic) NSString* taskName;

@property (readwrite, assign, nonatomic) id<GtLengthyTaskDelegate> delegate;

- (void) prepareTask;
- (void) executeTask;

// override points.
- (NSUInteger) calculateTotalStepCount; // returns totalStepCount

- (BOOL) shouldExecuteTask; // default returns YES
- (void) doExecuteTask;

// call these from task when incrementing step
- (void) incrementStep; 

@end

@protocol GtLengthyTaskDelegate <NSObject>
- (BOOL) lengthyTaskShouldBegin:(GtLengthyTask*) task;
- (void) lengthyTaskWillBegin:(GtLengthyTask*) task;
- (void) lengthyTaskDidIncrementStep:(GtLengthyTask*) task;
- (void) lengthyTaskDidChangeName:(GtLengthyTask*) task;
@end