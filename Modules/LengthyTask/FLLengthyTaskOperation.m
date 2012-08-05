//
//  FLLengthyTaskOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLLengthyTaskOperation.h"

@implementation FLLengthyTaskOperation

@synthesize lengthyTaskOperationDelegate = _lengthyTaskOperationDelegate;
@synthesize operationName = _operationName;

- (id) initWithLengthyTaskInput:(FLLengthyTask*) task operationName:(NSString*) operationName {
	if((self = [super init])) {
		self.operationName = operationName;
		self.operationInput = task;
	}
	
	return self;
}

- (void) dealloc {
	FLRelease(_operationName);
	FLSuperDealloc();
}

+ (FLLengthyTaskOperation*) lengthyTaskOperation:(FLLengthyTask*) task  operationName:(NSString*) operationName {
	return FLReturnAutoreleased([[FLLengthyTaskOperation alloc] initWithLengthyTaskInput:task operationName:operationName]);
}

- (void) lengthyTaskWillBegin:(FLLengthyTask*) task {
	[_lengthyTaskOperationDelegate lengthyTaskOperation:self lengthyTaskWillBegin:task];
}

- (void) lengthyTaskDidIncrementStep:(FLLengthyTask*) task {
	[_lengthyTaskOperationDelegate lengthyTaskOperation:self lengthyTaskDidIncrementStep:task];
}

- (void) lengthyTaskDidChangeName:(FLLengthyTask*) task {
	[_lengthyTaskOperationDelegate lengthyTaskOperation:self lengthyTaskDidChangeName:task];
}

- (BOOL) lengthyTaskShouldBegin:(FLLengthyTask *)task {
    return self.shouldPerform;
}

- (void) requestCancel {
	[super requestCancel];
	[self.operationInput requestCancel];
}

- (void) performSelf {
	FLLengthyTask* task = self.operationInput;
	@try {
		task.delegate = self;
		[task prepareTask];
		[_lengthyTaskOperationDelegate lengthyTaskOperation:self lengthyTaskWasPrepared:task];
		
		[task executeTask];
	}
	@finally {
        [_lengthyTaskOperationDelegate lengthyTaskOperation:self lengthyTaskDidFinish:task];
		task.delegate = nil;
	}

}

@end
