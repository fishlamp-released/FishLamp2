//
//  FLLengthyTaskList.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLLengthyTask.h"

@interface FLLengthyTaskList : FLLengthyTask<FLLengthyTaskDelegate> {
@private
	NSMutableArray* _taskList;
	FLLengthyTask* _currentTask;
}

@property (readonly, assign, nonatomic) NSUInteger count;

- (void) addLengthyTask:(FLLengthyTask*) task;

@end
