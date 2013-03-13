//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLResult.h"
#import "FLDispatchTypes.h"

#if DEBUG
#import "FLStackTrace.h"
#endif

@interface FLFinisher : NSObject {
@private
    dispatch_semaphore_t _semaphore;
    id _result;
    BOOL _finished;
    BOOL _finishOnMainThread;
    FLBlockWithResult _didFinish;
    id _observer;

#if DEBUG
    FLStackTrace* _createdStackTrace;
    FLStackTrace* _finishedStackTrace;
#endif    
}
@property (readwrite, strong) id observer;

@property (readonly, strong) FLResult result;
@property (readonly, assign, getter=isFinished) BOOL finished;

@property (readwrite, assign) BOOL finishOnMainThread;

// designated initializer
- (id) initWithResultBlock:(FLBlockWithResult) resultBlock;

// class instantiators
+ (id) finisher;

+ (id) finisher:(FLBlockWithResult) resultBlock;

+ (id) finisherWithResultBlock:(FLBlockWithResult) resultBlock;

// notify finish with one of these
- (void) setFinished;

- (void) setFinishedWithResult:(id) result;

- (void) setFinishedWithResult:(id) result 
                    completion:(FLBlock) notificationCompletionBlock;

// blocks in current thread. Will @throw error if [self.result error] 
- (id) waitUntilFinished;
@end

@interface FLFinisher (FLDispatcher)
- (void) setWillStartInDispatcher:(id<FLDispatcher>) dispatcher;
- (void) setWillBeDispatchedByDispatcher:(id<FLDispatcher>) dispatcher;
@end

