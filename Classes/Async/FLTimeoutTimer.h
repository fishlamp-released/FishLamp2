//
//  FLTimeoutTimer.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"

#import "FLFinisher.h"
#import "FLAsyncWorker.h"

@interface FLTimeoutTimer : FLObservable<FLAsyncWorker> {
@private
    NSTimeInterval _timestamp;
    NSTimeInterval _timeoutInterval;
//    BOOL _idle;
    BOOL _timedout;
    NSTimer* _timeoutTimer;
    FLFinisher* _finisher;
}
@property (readonly, assign) NSTimeInterval timeoutInterval;
@property (readonly, assign) NSTimeInterval timestamp;
@property (readonly, assign) NSTimeInterval idleDuration;

@property (readonly, assign) BOOL timedOut;

- (id) initWithTimeoutInterval:(NSTimeInterval) interval;
+ (FLTimeoutTimer*) timeoutTimer;
+ (FLTimeoutTimer*) timeoutTimer:(NSTimeInterval) timeoutInterval;

- (FLFinisher*) startTimer:(FLCompletionBlock) completionBlock;

- (void) requestCancel;
- (void) touchTimestamp;

@end

@protocol FLTimeoutTimerObserver <FLObserver>
- (void) timeoutTimerDidTimeout:(FLTimeoutTimer*) timer;
@end