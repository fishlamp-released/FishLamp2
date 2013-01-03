//
//  FLLengthyTaskList.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//
//
//#import "FLLengthyTaskList.h"
//
//
//@implementation FLLengthyTaskList
//
//- (id) init {
//	if((self = [super init])) {
//		_taskList = [[FLOperationQueue alloc] init];
//	}
//	
//	return self;
//}
//
//
////- (void) requestCancel:(dispatch_block_t) cancelCompletionOrNil {
////	[super requestCancel:cancelCompletionOrNil];
////	
////	for(FLLengthyTask* task in _taskList) {
////		[task requestCancel:nil];
////	}
////}
//
//- (NSUInteger) calculateTotalStepCount {
//	NSUInteger totalCount = 0;
//	for(FLLengthyTask* task in _taskList) {
//		[task prepareTask];
//		totalCount += task.totalStepCount;
//	}
//	return totalCount;
//}
//
//- (void) lengthyTaskWillBegin:(FLLengthyTask*) task {
//}
//
//- (BOOL) lengthyTaskShouldBegin:(FLLengthyTask *)task {
//    return [self.delegate lengthyTaskShouldBegin:task];
//}
//
//- (void) lengthyTaskDidChangeName:(FLLengthyTask*) task {
//	[self.delegate lengthyTaskDidChangeName:self];
//}
//
//- (void) lengthyTaskDidIncrementStep:(FLLengthyTask*) task {
//    self.stepCount++;
//}
//
//- (void) setTaskName:(NSString*) taskName {
//	FLAssertFailed_v(@"setting task name not support for list");
//}
//
//- (void) lengthyTaskDidFinish:(FLLengthyTask*) task {
//
//}
//
//- (NSString*) taskName  {
//	if(_currentTask) {
//		return _currentTask.taskName;
//	}
//	
//	return nil;
//}
//
//- (FLResult) runOperation {
//
//    for(FLLengthyTask* task in _taskList)
//	{
//        NSUInteger count = self.stepCount;
//    
//		@try {
//			_currentTask = task;
//			task.delegate = self;
//			[task executeTask];
//			self.stepCount = count + _currentTask.totalStepCount;
//		}
//		@finally
//		{
//			_currentTask = nil;
//			task.delegate = nil;
//		}
//	}
//}
//
//- (void) dealloc {
//	FLRelease(_taskList);
//	FLSuperDealloc();
//}
//
//- (void) addLengthyTask:(FLLengthyTask*) task {
//	[_taskList addObject:task];
//}
//
//- (NSUInteger) count {
//	return _taskList.count;
//}
//
//@end
