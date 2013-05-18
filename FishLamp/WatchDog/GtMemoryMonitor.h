//
//  GtMemoryMonitor.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#if GT_MEMORY_MONITOR

extern id GtMemoryMonitorUpdate(id obj);
extern void GtMemoryMonitorRelease(id obj);

#undef GtAlloc
#undef GtRelease
#undef GtWatch

#define GtAlloc(OBJ) GtMemoryMonitorUpdate([OBJ alloc])
#define GtRelease(OBJ) GtMemoryMonitorRelease(OBJ)
#define GtWatch(OBJ) GtMemoryMonitorUpdate(OBJ) 

@interface GtMemoryMonitor : NSObject {
@private
	NSUInteger m_last;
	NSUInteger m_highWater;
	
	CGFloat m_lastChange;
	 
	NSTimer* m_timer;
    
    UILabel* m_leftLabel;
    UILabel* m_rightLabel;
}

GtSingletonProperty(GtMemoryMonitor);

+ (id) update:(id) object;

- (void) start:(UIWindow*) window;
- (void) stop:(UIWindow*) window;

- (void) updateMemoryValues;

@end
#endif