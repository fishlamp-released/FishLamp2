//
//  FLLengthyTaskOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLLengthyTaskOperation.h"

@implementation FLLengthyTaskOperation

- (id) initWithLengthyTask:(FLLengthyTask*) task  {
	if((self = [super init])) {
		self.operationInput = task;
	}
	
	return self;
}

+ (FLLengthyTaskOperation*) lengthyTaskOperation:(FLLengthyTask*) task   {
	return autorelease_([[FLLengthyTaskOperation alloc] initWithLengthyTask:task]);
}

- (void) requestCancel {
	[super requestCancel];
	[self.operationInput requestCancel];
}

- (void) runSelf {
	FLLengthyTask* task = self.operationInput;
    [task prepareTask];
    [task executeTask];
}

@end
