//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLResult.h"
#import "FLCancellable.h"

@protocol FLFinisher <FLResultProducing, FLCancellable>
@property (readonly, strong) FLResult result;
@property (readonly, assign, getter=isFinished) BOOL finished;

- (void) setFinished;
- (void) setFinishedWithResult:(id) result;

// blocks in current thread
- (FLResult) waitUntilFinished;
- (void) waitOnce;


@end

typedef void (^FLFinisherNotificationScheduler)(dispatch_block_t finishBlock);
typedef void (^FLRequestCancelBlock)();

@interface FLFinisher : NSObject<FLFinisher> {
@private
    NSMutableArray* _subFinishers;
    FLFinisherNotificationScheduler _notificationScheduler;
    id _result;
    FLResultBlock _resultNotificationBlock;
    FLRequestCancelBlock _requestCancelBlock;
    SEL _resultNotificationAction;
    __unsafe_unretained id _resultNotificationTarget;
    
}

- (id) initWithResultBlock:(FLResultBlock) resultBlock;
- (id) initWithTarget:(id) target action:(SEL) action; // myMethod:(FLFinisher*) result;

+ (id) finisher;
+ (id) finisherWithResultBlock:(FLResultBlock) block;
+ (id) finisherWithTarget:(id) target action:(SEL) action;

- (void) addSubFinisher:(FLFinisher*) finisher;

// override point
- (void) didFinish;

@property (readwrite, strong) FLRequestCancelBlock requestCancelBlock;

// for rescheduling finish on different threads.
@property (readwrite, copy) FLFinisherNotificationScheduler notificationScheduler;
- (void) scheduleFinishOnMainThread;

@end
