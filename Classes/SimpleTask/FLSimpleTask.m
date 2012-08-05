//
//	FLSimpleTask.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLSimpleTask.h"

@implementation FLSimpleTask

- (void) dealloc
{
#if ! OBJC_ARC
	[_target performSelectorOnMainThread:@selector(release) withObject:nil waitUntilDone:NO];
#endif    
	FLSuperDealloc();
}

- (void) _performInForeground
{
	FLAssert([NSThread isMainThread], @"performing action on main thread");

    @try {
        FLPerformBlockInAutoreleasePool(^{
            [_target performSelector:_foregroundAction];
        });
    }
    @finally {
        FLReleaseWithNil(_target);
    }
}

- (void) _performInBackground
{
	FLPerformBlockInAutoreleasePool(^{
    	FLAssert(![NSThread isMainThread], @"performing action on main thread");
	
		[_target performSelector:_backgroundAction];
		[self performSelectorOnMainThread:@selector(_performInForeground) withObject:nil waitUntilDone:NO];
	});
}

- (void) beginTaskOnQueue:(NSOperationQueue*) queue 
	target :(id) target 
	backgroundAction:(SEL) backgroundAction 
	foregroundAction:(SEL) foregroundAction
{
	_target = FLReturnRetained(target);
	_backgroundAction = backgroundAction;
	_foregroundAction = foregroundAction;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self _performInBackground];
        });
}
@end

