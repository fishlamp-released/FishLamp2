//
//	GtMemoryMonitor.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#if __GT_MEMORY_MONITOR
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <sys/sysctl.h>
#import <mach/task_info.h>
@interface GtMemoryMonitor : NSObject<GtAllocationHookProtocol> {
@private
	mach_msg_type_number_t m_last;
	mach_msg_type_number_t m_highWater;
	
	NSTimeInterval m_lastChange;
	 
	NSTimer* m_timer;
	
	UILabel* m_leftLabel;
	UILabel* m_rightLabel;
	
	id<GtAllocationHookProtocol> m_previousHook;
	
	int32_t m_started;
}

GtSingletonProperty(GtMemoryMonitor);

- (void) start:(UIWindow*) window;
- (void) stop:(UIWindow*) window;

- (void) updateMemoryValues;

@end
#endif