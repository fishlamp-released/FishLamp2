//
//	FLActionQueue.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/5/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCallbackObject.h"

#define FLDefaultActionQueueTimerDelay 0.0

@interface FLActionQueue : NSObject {
@private
	NSMutableArray* _operations;
	NSTimer* _nextOperationTimer;
	CGFloat _timerDelay;
}

@property (readwrite, assign, nonatomic) CGFloat timerDelay;

- (id) init;
- (id) initWithTimerDelay:(CGFloat) delay;

- (void) cancel;
- (void) queueAction:(FLCallbackObject*) callback;

@end
