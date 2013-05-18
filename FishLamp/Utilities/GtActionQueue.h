//
//  GtActionQueue.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/5/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#include "GtSimpleCallback.h"

#define GtDefaultActionQueueTimerDelay 0.0

@interface GtActionQueue : NSObject {
@private
	NSMutableArray* m_operations;
	NSTimer* m_nextOperationTimer;
	CGFloat m_timerDelay;
}

@property (readwrite, assign, nonatomic) CGFloat timerDelay;

- (id) init;
- (id) initWithTimerDelay:(CGFloat) delay;

- (void) cancel;
- (void) queueAction:(GtSimpleCallback*) callback;

@end
