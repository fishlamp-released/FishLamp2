//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLResult.h"
#import "FLObserver.h"
#import "FLDispatcher.h"

@class FLFinisher;
@class FLStackTrace;

typedef void (^FLFinisherNotificationSchedulerBlock)(dispatch_block_t notifier);
typedef void (^FLFinisherResultBlock)(FLResult result);

@interface FLFinisher : FLObserver {
@private
    dispatch_semaphore_t _semaphore;
    id _result;
    BOOL _finished;
    BOOL _finishOnMainThread;
    FLFinisherResultBlock _didFinish;

#if DEBUG
    FLStackTrace* _createdStackTrace;
    FLStackTrace* _finishedStackTrace;
#endif    
}

@property (readonly, strong) FLResult result;
@property (readonly, assign, getter=isFinished) BOOL finished;

@property (readwrite, assign) BOOL finishOnMainThread;

// designated initializer
- (id) initWithResultBlock:(FLResultBlock) resultBlock;

// class instantiators
+ (id) finisher;

+ (id) finisher:(FLResultBlock) resultBlock;

+ (id) finisherWithResultBlock:(FLResultBlock) resultBlock;

// notify finish with one of these
- (void) setFinished;

- (void) setFinishedWithResult:(id) result;

- (void) setFinishedWithResult:(id) result 
                    completion:(dispatch_block_t) notificationCompletionBlock;

// blocks in current thread. Will @throw error if [self.result error] 
- (id) waitUntilFinished;
@end

@interface FLFinisher (FLDispatcher)
- (void) setWillStartInDispatcher:(id<FLDispatcher>) dispatcher;
- (void) setWillBeDispatchedByDispatcher:(id<FLDispatcher>) dispatcher;
@end


@protocol FLFinisherObserving <NSObject>
- (void) finisher:(FLFinisher*) finisher wasDispatchedInDispatcher:(id<FLDispatcher>) dispatcher;
- (void) finisher:(FLFinisher*) finisher willStartInDispatcher:(id<FLDispatcher>) dispatcher;
- (void) finisher:(FLFinisher*) finisher didFinishWithResult:(FLResult) result;
@end

@protocol FLAsyncWorker <NSObject>
- (void) startWorking:(FLFinisher*) finisher;
@end
