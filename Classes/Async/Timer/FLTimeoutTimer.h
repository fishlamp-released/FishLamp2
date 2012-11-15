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
#import "FLObservable2.h"

extern const NSString* FLTimeoutTimerCheckEvent;
extern const NSString* FLTimeoutTimerTimeoutEvent;


// TODO: this .25 for progress. It could be closer to 1 second if
// we don't need to report progress. We should be able to set this per
// connection for sure.        
extern const NSTimeInterval FLTimeoutTimerDefaultCheckFrequencyInterval;

@interface FLTimeoutTimer : FLObservable2<FLWorker> {
@private
    NSTimeInterval _timestamp;
    NSTimeInterval _timeoutInterval;
    NSTimeInterval _checkFrequency;
    BOOL _timedOut;
    NSTimer* _timer;
    id<FLFinisher> _finisher;
    __unsafe_unretained NSThread* _thread;
}
@property (readonly, assign) NSTimeInterval timeoutInterval;
@property (readonly, assign) NSTimeInterval timestamp;
@property (readonly, assign) NSTimeInterval idleDuration;
@property (readonly, assign) NSTimeInterval checkFrequency;

@property (readonly, assign) BOOL timedOut;

- (id) initWithTimeoutInterval:(NSTimeInterval) interval;
+ (FLTimeoutTimer*) timeoutTimer;
+ (FLTimeoutTimer*) timeoutTimer:(NSTimeInterval) timeoutInterval;

- (id<FLPromisedResult>) startTimerWithFrequency:(NSTimeInterval) checkFrequency
                                      completion:(FLResultBlock) completion;
                                      
- (id<FLPromisedResult>) startTimer:(FLResultBlock) completion;

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
