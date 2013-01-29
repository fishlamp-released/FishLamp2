//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLResult.h"
@class FLFinisher;
@class FLStackTrace;

typedef void (^FLFinisherNotificationSchedulerBlock)(dispatch_block_t notifier);
typedef void (^FLFinishableBlock)(FLFinisher* finisher);
typedef void (^FLFinisherResultBlock)(FLResult result);

@interface FLFinisher : NSObject {
@private
    id _result;
    dispatch_block_t _notificationCompletionBlock;
    dispatch_semaphore_t _semaphore;
    FLFinisherNotificationSchedulerBlock _scheduleNotificationBlock;
    BOOL _finished;
    
#if DEBUG
    FLStackTrace* _createdStackTrace;
    FLStackTrace* _finishedStackTrace;
#endif    
}

@property (readonly, strong) FLResult result;
@property (readonly, assign, getter=isFinished) BOOL finished;

// for rescheduling finish on different threads. 
@property (readwrite, copy) FLFinisherNotificationSchedulerBlock scheduleNotificationBlock;

- (id) initWithResultBlock:(FLResultBlock) resultBlock;

+ (id) finisher;
+ (id) finisher:(FLResultBlock) resultBlock;
+ (id) finisherWithResultBlock:(FLResultBlock) resultBlock;

- (void) setFinished;

- (void) setFinishedWithResult:(id) result;

- (void) setFinishedWithResult:(id) result 
                    completion:(dispatch_block_t) notificationCompletionBlock;

// blocks in current thread. Will @throw error if [self.result error] 
- (id) waitUntilFinished;

// optional stuff

+ (FLFinisherNotificationSchedulerBlock) scheduleNotificationInMainThreadBlock;

@end


@interface FLMainThreadFinisher : FLFinisher
@end


