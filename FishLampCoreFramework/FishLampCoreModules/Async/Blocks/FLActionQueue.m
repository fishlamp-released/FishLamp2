////
////	FLActionQueue.m
////	FishLamp
////
////	Created by Mike Fullerton on 10/5/09.
////	Copyright 2009 GreenTongue Software. All rights reserved.
////
//
//#import "FLActionQueue.h"
//#import "FLCallbackObject.h"
//
//
//
//@interface FLActionQueue (Private)
//
//- (void) scheduleNextOperation;
//
//@end
//
//
//@implementation FLActionQueue
//
//@synthesize timerDelay = _timerDelay;
//
//- (id) initWithTimerDelay:(CGFloat) delay
//{
//	if((self = [super init]))
//	{
//		_operations = [[NSMutableArray alloc] init];
//		_timerDelay = delay;
//	}
//	
//	return self;
//}
//
//- (id) init
//{
//	return [self initWithTimerDelay:FLDefaultActionQueueTimerDelay];;
//}
//
//- (void) cancel
//{
//	if(_nextOperationTimer)
//	{
//		[_nextOperationTimer invalidate];
//		_nextOperationTimer = nil; 
//	}
//}
//
//- (void) performNextOperation
//{
//	_nextOperationTimer = nil;
//
//	FLCallbackObject* cb = [_operations objectAtIndex:0];
//	[cb invoke:nil];
//	
//	[_operations removeObjectAtIndex:0];
//	
//	if(_operations.count > 0)
//	{
//		[self scheduleNextOperation];
//	}
//}
//
//- (void) scheduleNextOperation
//{
//	if(!_nextOperationTimer)
//	{
//		_nextOperationTimer = [NSTimer timerWithTimeInterval:_timerDelay 
//				target:self 
//				selector:@selector(performNextOperation) 
//				userInfo:nil 
//				repeats:NO];
//			
//		[[NSRunLoop mainRunLoop] addTimer:_nextOperationTimer forMode:NSDefaultRunLoopMode];
//	}
//}
//
//- (void) queueAction:(FLCallbackObject*) callback
//{
//	[_operations addObject:callback];
//	[self scheduleNextOperation];
//}
//
//- (void)dealloc 
//{
//	[self cancel];
//	FLReleaseWithNil_(_operations);
//	super_dealloc_();
//}
//
//@end
