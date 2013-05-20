//
//	GtActionQueue.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/5/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCallbackObject.h"

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
- (void) queueAction:(GtCallbackObject*) callback;

@end
