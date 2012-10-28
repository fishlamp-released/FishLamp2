//
//  FLAsyncWorker.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

@protocol FLAsyncFinisher;
@protocol FLAsyncResult;

typedef void (^FLCompletionBlock)(id<FLAsyncResult> result);
typedef void (^FLConditionalBlock)(BOOL* condition);

@protocol FLAsyncFinisher <NSObject>
@property (readonly, assign, getter=isFinished) BOOL finished;

- (void) setFinished;
- (void) setFinishedWithResult:(id<FLAsyncResult>) result;

- (void) waitUntilFinished;
- (void) waitUntilFinishedWhileCondition:(FLConditionalBlock) checkCondition;
@end

@protocol FLAsyncWorker <NSObject>
- (void) startWorking:(id<FLAsyncFinisher>) finisher;

@optional
- (BOOL) handleAsyncWorkerError:(NSError*) error;
@end

@protocol FLAsyncWorkerErrorDelegate <NSObject>
- (void) asyncWorker:(id<FLAsyncWorker>) worker
    encounteredError:(NSError*) error
            finisher:(id<FLAsyncFinisher>) finisher;
@end

@protocol FLAsyncResult <FLAsyncFinisher>
@property (readonly, assign) BOOL didRunSynchronously;
@property (readonly, strong) NSError* error;
@property (readonly, strong) id asyncResult;
@end

@protocol FLAsyncWorkStarter <NSObject>
- (id<FLAsyncFinisher>) startWorker:(id<FLAsyncWorker>) worker
                         completion:(FLCompletionBlock) completion;
@end

#define FLTryHandlingWorkerException(__EX__) \
    if(![self performIfRespondsToSelector:@selector(handleAsyncWorkerError:) withObject:__EX__.error]) @throw

typedef void (^FLAsyncWorkerBlock)(id<FLAsyncFinisher> finisher);

@interface FLAsyncWorker : NSObject<FLAsyncWorker> {
@private
    FLAsyncWorkerBlock _asyncWorkerBlock;
}
- (id) initWithAsyncWorkerBlock:(FLAsyncWorkerBlock) block;
+ (id) asyncWorker:(FLAsyncWorkerBlock) block;

@end