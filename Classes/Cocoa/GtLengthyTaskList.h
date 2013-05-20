//
//  GtLengthyTaskList.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtLengthyTask.h"

@interface GtLengthyTaskList : GtLengthyTask<GtLengthyTaskDelegate> {
@private
	NSMutableArray* m_taskList;
	GtLengthyTask* m_currentTask;
}

@property (readonly, assign, nonatomic) NSUInteger count;

- (void) addLengthyTask:(GtLengthyTask*) task;

@end
