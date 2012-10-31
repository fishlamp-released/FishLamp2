//
//	FLPerformSelectorOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLPerformSelectorOperation.h"

@implementation FLPerformSelectorOperation

- (id) initWithTarget:(id) target action:(SEL) action {
	if((self = [super init])) {
		[self setCallback:target action:action];
	}
	
	return self;
}

+ (id) performSelectorOperation:(id) target action:(SEL) action {
	return autorelease_([[[self class] alloc] initWithTarget:target action:action]);
}

- (void) runSelf {
    if(_target) {
        [_target performSelectorSafely:_action withObject:self];
    }

}

- (void) setCallback:(id) target action:(SEL) action {
	
    _target = target;
    _action = action;
    
	FLAssert_v([_target respondsToSelector:_action], @"target doesn't respond to selector");
}
@end

#if TEST

#import "FLUnitTest.h"

@interface FLAsyncTest : FLUnitTest {
}

@end

@implementation FLAsyncTest

- (void) _didExecuteOperation:(FLPerformSelectorOperation*) operation
{
	FLTestLog(@"did execute");
}

- (void) _asyncDone:(FLPerformSelectorOperation*) operation
{
//	[operation finishAsync];
	
//	FLAssert_v(operation.isFinished, @"not performed");
//	  FLAssert_v(operation.wasStarted, @"not started");
//
//	[[FLTestCase currentTestCase] didCompleteAsyncTest];
}

- (void) testAsyncOperation {
    
//    FLAsyncRunner* async = [FLAsyncRunner asyncRunner];
//    
//    [async start:^{
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//                [async setFinished];
//                });
//        }];
//    
//    [async waitForFinish];
//    
//    FLAssert_(async.isFinished);
    
//	FLPerformSelectorOperation* operation = [FLPerformSelectorOperation performSelectorOperation:self action:@selector(_didExecuteOperation:)];
//
//	  [operation startAsync:FLCallbackMake(operation, @selector(_asyncDone:))];
//	  
//	  [testCase blockUntilTestCompletes];
}

@end


#endif