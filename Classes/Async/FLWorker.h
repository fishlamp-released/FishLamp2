//
//  FLWorker.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

@protocol FLFinisher;
@protocol FLResult;

typedef void (^FLCompletionBlock)(id<FLResult> result);
typedef void (^FLConditionalBlock)(BOOL* condition);
typedef void (^FLWorkerBlock)(id<FLFinisher> finisher);

@protocol FLResult <NSObject>
@property (readonly, assign, nonatomic) BOOL didSucceed;
@property (readonly, assign, nonatomic) BOOL finishedSynchronously;
@property (readonly, strong, nonatomic) NSError* error;
@property (readonly, strong, nonatomic) id output;
@end

@protocol FLFinisher <NSObject>
@property (readonly, assign) BOOL isFinished;
@property (readonly, strong) id<FLResult> result;
- (void) setFinished;
- (void) setFinishedWithResult:(id<FLResult>) output;
@end

@protocol FLResultPromise <NSObject>
@property (readonly, assign) BOOL hasResult;
@property (readonly, strong) id<FLResult> result;
- (id<FLResult>) waitForResult;
- (id<FLResult>) waitForResultWithCondition:(FLConditionalBlock) checkCondition;
- (id<FLResult>) waitForResultWithTimeout:(NSTimeInterval) timeout;
@end

// performer?

@protocol FLWorker <NSObject>
- (void) startWorking:(id<FLFinisher>) finisher;
@end

@protocol FLRunnable <NSObject>
- (id<FLResultPromise>) start:(FLCompletionBlock) completion;
- (id<FLResult>) runSynchronously;
@end

@protocol FLWorkerErrorHandler <NSObject>
@optional
- (BOOL) handleAsyncWorkerError:(NSError*) error;
@end

@protocol FLWorkerErrorDelegate <NSObject>
- (void) asyncWorker:(id<FLWorker>) worker
    encounteredError:(NSError*) error
            finisher:(id<FLFinisher>) finisher;
@end

#define FLTryHandlingWorkerException(__EX__) \
    if(![self performIfRespondsToSelector:@selector(handleAsyncWorkerError:) withObject:__EX__.error]) @throw

@interface FLWorker : NSObject<FLWorker> {
@private
    FLWorkerBlock _asyncWorkerBlock;
}
- (id) initWithAsyncWorkerBlock:(FLWorkerBlock) block;
+ (id) asyncWorker:(FLWorkerBlock) block;

@end

@interface FLResult : NSObject<FLResult> {
@private
    NSError* _error;
    id _returnedObject;
}
- (id) initWithOutput:(id) object;
- (id) initWithError:(NSError*) error;
+ (id) result:(id) output;
+ (id) resultWithError:(NSError*) error;
@end

@interface FLAsyncResult : FLResult
@end
