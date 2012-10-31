//
//  FLTimeoutTimer.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"

#import "FLWorkFinisher.h"
#import "FLWorker.h"

@interface FLTimeoutTimer : FLObservable<FLWorker, FLRunnable> {
@private
    NSTimeInterval _timestamp;
    NSTimeInterval _timeoutInterval;
//    BOOL _idle;
    BOOL _timedOut;
    NSTimer* _timer;
    id<FLFinisher> _finisher;
    __unsafe_unretained NSThread* _thread;
}
@property (readonly, assign) NSTimeInterval timeoutInterval;
@property (readonly, assign) NSTimeInterval timestamp;
@property (readonly, assign) NSTimeInterval idleDuration;

@property (readonly, assign) BOOL timedOut;

- (id) initWithTimeoutInterval:(NSTimeInterval) interval;
+ (FLTimeoutTimer*) timeoutTimer;
+ (FLTimeoutTimer*) timeoutTimer:(NSTimeInterval) timeoutInterval;

- (void) requestCancel;
- (void) touchTimestamp;

@end

@protocol FLTimeoutTimerObserver <FLObserver>
- (void) timeoutTimerDidTimeout:(FLTimeoutTimer*) timer;
@end

@interface NSError (FLTimeout)
+ (NSError*) timeoutError;
@property (readonly, nonatomic) BOOL isTimeoutError;
@end
