//
//  GtLengthyTaskOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLengthyTaskOperation.h"

@implementation GtLengthyTaskOperation

@synthesize lengthyTaskOperationDelegate = m_lengthyTaskOperationDelegate;
@synthesize operationName = m_operationName;

- (id) initWithLengthyTaskInput:(GtLengthyTask*) task operationName:(NSString*) operationName;
{
	if((self = [super init]))
	{
		self.operationName = operationName;
		self.operationInput = task;
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_operationName);
	GtSuperDealloc();
}

+ (GtLengthyTaskOperation*) lengthyTaskOperation:(GtLengthyTask*) task  operationName:(NSString*) operationName;
{
	return GtReturnAutoreleased([[GtLengthyTaskOperation alloc] initWithLengthyTaskInput:task operationName:operationName]);
}

- (void) lengthyTaskWillBegin:(GtLengthyTask*) task
{
	[m_lengthyTaskOperationDelegate lengthyTaskOperation:self lengthyTaskWillBegin:task];
}

- (void) lengthyTaskDidIncrementStep:(GtLengthyTask*) task
{
	[m_lengthyTaskOperationDelegate lengthyTaskOperation:self lengthyTaskDidIncrementStep:task];
}

- (void) lengthyTaskDidChangeName:(GtLengthyTask*) task
{
	[m_lengthyTaskOperationDelegate lengthyTaskOperation:self lengthyTaskDidChangeName:task];
}

- (BOOL) lengthyTaskShouldBegin:(GtLengthyTask *)task
{
    return self.shouldPerform;
}

- (void) requestCancel
{
	[super requestCancel];
	[self.operationInput requestCancel];
}

- (void) performSelf
{
	GtLengthyTask* task = self.operationInput;
	@try
	{
		task.delegate = self;
		[task prepareTask];
		[m_lengthyTaskOperationDelegate lengthyTaskOperation:self lengthyTaskWasPrepared:task];
		
		[task executeTask];
	}
	@finally {
		task.delegate = nil;
	}

}

@end
