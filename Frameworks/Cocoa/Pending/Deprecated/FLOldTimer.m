////
////	FLTimer.m
////	FishLamp
////
////	Created by Mike Fullerton on 9/14/10.
////	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
////
//
//#import "FLTimer.h"
//
//@implementation FLWeaklyReferencedTimer
//
//- (id) initWithWeaklyReferencedTarget:(id) target action:(SEL) action {
//	if((self = [super init])) {
//		_target = [[FLWeakReference alloc] initWithObject:target];
//		_action = action;
//	}
//	return self;
//}
//
//#pragma GCC diagnostic push
//#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"
//
//- (void) timerCallback:(id) timer
//{
//    id target = _target.object;
//	if(target) {
//		[target performSelector:_action withObject:timer];
//	}
//	else
//	{
//		[self stopTimer];
//	}
//}
//
//#pragma GCC diagnostic pop
//
//
//- (void) stopTimer
//{
//	if(_timer)
//	{
//		[_timer invalidate];
//		_timer = nil;
//	}
//}
//
//- (void)startTimerWithTimeInterval:(NSTimeInterval) interval 
//	repeats:(BOOL) repeats
//	inRunLoop:(NSRunLoop*) runLoop
//{
//	[self stopTimer];
//	
//	_timer = [NSTimer timerWithTimeInterval:interval
//				target:self 
//				selector:@selector(timerCallback:) 
//				userInfo:nil 
//				repeats:repeats];
//				
//	[runLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
//}
//
//
//- (void) dealloc
//{
//	[self stopTimer];
//	FLRelease(_target);
//	FLSuperDealloc();
//}
//
//@end
//
//@implementation FLTimer
//
//@synthesize startTime = _startTime;
//@synthesize endTime = _endTime;
//@synthesize lastUpdateTimeStamp = _lastUpdateTimeStamp;
//@synthesize timeoutInterval = _timeoutInterval;
//@synthesize delegate = _delegate;
//
//FLSynthesizeStructProperty(isTiming, setIsTiming, BOOL, _timerFlags);
//FLSynthesizeStructProperty(logEvents, setLogEvents, BOOL, _timerFlags);
//
//- (void) _killTimer
//{
//	if(_timer)
//	{
//		[_timer stopTimer];
//		FLReleaseWithNil(_timer);
//		_timeoutCallback.target = nil;
//		_timeoutCallback.action = nil;
//	}
//}
//
//- (void) _stopTiming
//{
//	[self _killTimer];
//	
//	if(self.isTiming)
//	{
//		self.isTiming = NO;
//		_endTime = [NSDate timeIntervalSinceReferenceDate];
//	
//		_timeoutCallback.target = nil;
//		_timeoutCallback.action = nil;
//	
//#if DEBUG
//		if(self.logEvents)
//		{
//			FLDebugLog([self description]);
//		}
//#endif
//	}
//}
//
//- (void) _didTimeOut
//{
//#if DEBUG
//	if(self.logEvents)
//	{
//		FLDebugLog([self description]);
//	}
//#endif
//	[self _killTimer];
//		
//	FLInvokeCallback(_timeoutCallback, self);
//}
//
//- (void) timerTimeoutCheckCallback:(id) sender
//{
//	_lastTimeoutCheck = [NSDate timeIntervalSinceReferenceDate];
//	if((_lastTimeoutCheck - _lastUpdateTimeStamp) > _timeoutInterval)
//	{
//		[self _didTimeOut];
//	} 
//}
//
//- (void) restartTimeoutTimer:(NSRunLoop*) inRunLoop
//{
//	self.isTiming = YES;
//	_lastTimeoutCheck = 0;
//	_endTime = 0;
//	_startTime = [NSDate timeIntervalSinceReferenceDate];
//	_lastUpdateTimeStamp = _startTime;
//
//	[self _killTimer];
//	
//	if(_timeoutInterval)
//	{
//		_timer = [[FLWeaklyReferencedTimer alloc] initWithWeaklyReferencedTarget:self action:@selector(timerTimeoutCheckCallback:)];
//		[_timer startTimerWithTimeInterval:1.0 repeats:YES inRunLoop:inRunLoop];
//	}
//
//#if DEBUG
//		if(self.logEvents)
//		{
//			FLDebugLog([self description]);
//		}
//#endif		   
//
//}
//
//- (void) startTiming:(NSRunLoop*) inRunLoop
//{
//	@synchronized(self) 
//	{	
//		[self restartTimeoutTimer:inRunLoop];		 
//	}
//}
//
//- (void) startTimeoutTimer:(NSRunLoop*) inRunLoop
//                   timeout:(NSTimeInterval) timeout
//                    target:(id) target
//                    action:(SEL) action
//{
//	_timeoutInterval = timeout;
//	_timeoutCallback = FLCallbackMake(target, action);
//	[self startTiming:inRunLoop];
//}
//
//- (NSTimeInterval) elapsedTime
//{
//	@synchronized(self) {
//		return self.isTiming ?
//			[NSDate timeIntervalSinceReferenceDate] - _startTime :
//			_endTime - _startTime;
//	}
//	
//	return 0;
//}
//
////- (void) prettyDescription:(FLFancyString*) builder
////{
////#if IOS
////	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
////	[dateFormatter setDateStyle:kCFDateFormatterNoStyle];
////	[dateFormatter setTimeStyle:kCFDateFormatterMediumStyle];
////
////	[builder appendLineWithFormat:@"Started: %@",
////		[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:_startTime]]];
////	
////	if(_endTime > 0)
////	{	
////	  [builder appendLineWithFormat:@"Stopped: %@",
////		[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:_endTime]]];
////	} 
////
////	[builder appendLineWithFormat:@"Elapsed: %f seconds", self.elapsedTime]; 
////	
////	if([_delegate respondsToSelector:@selector(timer:describeTimedObjectToBuilder:)])
////	{
////		[builder appendLine:@"Timed Object:"];
////		[_delegate timer:self describeTimedObjectToBuilder:builder];
////	}
////	
////	FLReleaseWithNil(dateFormatter);
////#endif
////}
//
////- (BOOL) willPrettyDescribe
////{
////	return YES;
////}
//
////- (NSString*) description
////{
////	return [self prettyDescription];
////}
//
//- (void) stopTiming
//{
//	@synchronized(self) {
//		[self _stopTiming];
//	}
//}
//
//- (void) dealloc
//{	
//	[self _killTimer];
//	FLSuperDealloc();
//}
//
//- (void) updateTimeStamp 
//{
//	@synchronized(self) {
//		_lastUpdateTimeStamp = [NSDate timeIntervalSinceReferenceDate];
//	}
//}
//
//@end
//
//
