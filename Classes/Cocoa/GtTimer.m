//
//	GtTimer.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/14/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTimer.h"

@implementation GtWeaklyReferencedTimer

- (id) initWithWeaklyReferencedTarget:(id) target action:(SEL) action
{
	if((self = [super init]))
	{
		m_target = [[GtWeakReference alloc] init];
		m_target.object = target;
		m_action = action;
	}
	return self;
}

- (void) timerCallback:(id) timer
{
	if(m_target.object)
	{
		[m_target.object performSelector:m_action withObject:timer];
	}
	else
	{
		[self stopTimer];
	}
}

- (void) stopTimer
{
	if(m_timer)
	{
		[m_timer invalidate];
		m_timer = nil;
	}
}

- (void)startTimerWithTimeInterval:(NSTimeInterval) interval 
	repeats:(BOOL) repeats
	inRunLoop:(NSRunLoop*) runLoop
{
	[self stopTimer];
	
	m_timer = [NSTimer timerWithTimeInterval:interval
				target:self 
				selector:@selector(timerCallback:) 
				userInfo:nil 
				repeats:repeats];
				
	[runLoop addTimer:m_timer forMode:NSDefaultRunLoopMode];
}


- (void) dealloc
{
	[self stopTimer];
	GtRelease(m_target);
	GtSuperDealloc();
}

@end

@implementation GtTimer

@synthesize startTime = m_startTime;
@synthesize endTime = m_endTime;
@synthesize lastUpdateTimeStamp = m_lastUpdateTimeStamp;
@synthesize timeoutInterval = m_timeoutInterval;
@synthesize delegate = m_delegate;

GtSynthesizeStructProperty(isTiming, setIsTiming, BOOL, m_timerFlags);
GtSynthesizeStructProperty(logEvents, setLogEvents, BOOL, m_timerFlags);

- (void) _killTimer
{
	if(m_timer)
	{
		[m_timer stopTimer];
		GtReleaseWithNil(m_timer);
		m_timeoutCallback.target = nil;
		m_timeoutCallback.action = nil;
	}
}

- (void) _stopTiming
{
	[self _killTimer];
	
	if(self.isTiming)
	{
		self.isTiming = NO;
		m_endTime = [NSDate timeIntervalSinceReferenceDate];
	
		m_timeoutCallback.target = nil;
		m_timeoutCallback.action = nil;
	
#if DEBUG
		if(self.logEvents)
		{
			GtLog(@"%@", [self description]);
		}
#endif
	}
}

- (void) _didTimeOut
{
#if DEBUG
	if(self.logEvents)
	{
		GtLog(@"%@", [self description]);
	}
#endif
	[self _killTimer];
		
	GtInvokeCallback(m_timeoutCallback, self);
}

- (void) timerTimeoutCheckCallback:(id) sender
{
	m_lastTimeoutCheck = [NSDate timeIntervalSinceReferenceDate];
	if((m_lastTimeoutCheck - m_lastUpdateTimeStamp) > m_timeoutInterval)
	{
		[self _didTimeOut];
	} 
}

- (void) restartTimeoutTimer:(NSRunLoop*) inRunLoop
{
	self.isTiming = YES;
	m_lastTimeoutCheck = 0;
	m_endTime = 0;
	m_startTime = [NSDate timeIntervalSinceReferenceDate];
	m_lastUpdateTimeStamp = m_startTime;

	[self _killTimer];
	
	if(m_timeoutInterval)
	{
		m_timer = [[GtWeaklyReferencedTimer alloc] initWithWeaklyReferencedTarget:self action:@selector(timerTimeoutCheckCallback:)];
		[m_timer startTimerWithTimeInterval:1.0 repeats:YES inRunLoop:inRunLoop];
	}

#if DEBUG
		if(self.logEvents)
		{
			GtLog(@"%@", [self description]);
		}
#endif		   

}

- (void) startTiming:(NSRunLoop*) inRunLoop
{
	@synchronized(self) 
	{	
		[self restartTimeoutTimer:inRunLoop];		 
	}
}

- (void) startTimeoutTimer:(NSRunLoop*) inRunLoop timeout:(NSTimeInterval) timeout target:(id) target action:(SEL) action;
{
	m_timeoutInterval = timeout;
	m_timeoutCallback = GtCallbackMake(target, action);
	[self startTiming:inRunLoop];
}

- (NSTimeInterval) elapsedTime
{
	@synchronized(self) {
		return self.isTiming ?
			[NSDate timeIntervalSinceReferenceDate] - m_startTime :
			m_endTime - m_startTime;
	}
	
	return 0;
}

- (void) describeSelf:(GtStringBuilder*) builder
{
#if IOS
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:kCFDateFormatterNoStyle];
	[dateFormatter setTimeStyle:kCFDateFormatterMediumStyle];

	[builder appendLineWithFormat:@"Started: %@",
		[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:m_startTime]]];
	
	if(m_endTime > 0)
	{	
	  [builder appendLineWithFormat:@"Stopped: %@",
		[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:m_endTime]]];
	} 

	[builder appendLineWithFormat:@"Elapsed: %f seconds", self.elapsedTime]; 
	
	if([m_delegate respondsToSelector:@selector(timer:describeTimedObjectToBuilder:)])
	{
		[builder appendLine:@"Timed Object:"];
		[m_delegate timer:self describeTimedObjectToBuilder:builder];
	}
	
	GtReleaseWithNil(dateFormatter);
#endif
}


//- (NSString*) description
//{
//	return [self prettyDescription];
//}

- (void) stopTiming
{
	@synchronized(self) {
		[self _stopTiming];
	}
}

- (void) dealloc
{	
	[self _killTimer];
	GtSuperDealloc();
}

- (void) updateTimeStamp 
{
	@synchronized(self) {
		m_lastUpdateTimeStamp = [NSDate timeIntervalSinceReferenceDate];
	}
}

@end
