//
//	FLMemoryMonitor.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/20/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#if __FL_MEMORY_MONITOR

#import <mach/mach.h>
#import <mach/mach_host.h>
#import <sys/sysctl.h>
#import <mach/task_info.h>
@interface FLMemoryMonitor : NSObject<FLAllocationHookProtocol> {
@private
	mach_msg_type_number_t _last;
	mach_msg_type_number_t _highWater;
	
	NSTimeInterval _lastChange;
	 
	NSTimer* _timer;
	
	UILabel* _leftLabel;
	UILabel* _rightLabel;
	
	id<FLAllocationHookProtocol> _previousHook;
	
	int32_t _started;
}

FLSingletonProperty(FLMemoryMonitor);

- (void) start:(UIWindow*) window;
- (void) stop:(UIWindow*) window;

- (void) updateMemoryValues;

@end
#endif