//
//	FLPerformSelectorOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLPerformSelectorOperation.h"

@implementation FLPerformSelectorOperation

@synthesize callback = _callback;

- (id) initWithTarget:(id) target action:(SEL) action
{
	if((self = [super init]))
	{
		[self setCallback:target action:action];
	}
	
	return self;
}

+ (FLPerformSelectorOperation*) performSelectorOperation:(id) target action:(SEL) action
{
	return FLReturnAutoreleased([[FLPerformSelectorOperation alloc] initWithTarget:target action:action]);
}
//
//- (void) dealloc
//{
//	  [_callback.target release];
//	  FLSuperDealloc();
//}

- (void) performSelf
{
	FLInvokeCallback(_callback, self);
}

- (void) setCallback:(id) target action:(SEL) action
{
	FLAssertIsNotNil(target);
	FLAssertIsNotNil(action);
	
	FLAssert([target respondsToSelector:action], @"target doesn't respond to selector");

	_callback = FLCallbackMake(target, action);
}

#if TEST

#import "FLUnitTest.h"

+ (void) _didExecuteOperation:(FLPerformSelectorOperation*) operation
{
	FLDebugLog(@"did execute");
}

- (void) _asyncDone:(FLPerformSelectorOperation*) operation
{
//	[operation finishOperation];
	
//	FLAssert(operation.wasPerformed, @"not performed");
//	  FLAssert(operation.wasStarted, @"not started");
//
//	[[FLUnitTest currentTest] didCompleteAsyncTest];
}

+ (void) _unitTestAsyncOperation:(FLUnitTest*) unitTest
{
    [unitTest log:@"hi from the test"];
    
    [unitTest lock];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [unitTest log:@"log from thread"];
        [unitTest unlock];
        } );
        
    [unitTest blockUntilUnlocked:5];

    [unitTest log:@"done"];

//	FLPerformSelectorOperation* operation = [FLPerformSelectorOperation performSelectorOperation:self action:@selector(_didExecuteOperation:)];
//
//	  [operation startOperation:FLCallbackMake(operation, @selector(_asyncDone:))];
//	  
//	  [unitTest blockUntilTestCompletes];
}

+ (void) _unitTestAnotherTest:(FLUnitTest*) unitTest {
    [unitTest log:@"hi %@", @"this is mike"];
}
#endif

@end


