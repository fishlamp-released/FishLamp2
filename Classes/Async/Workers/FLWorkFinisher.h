//
//  FLWorkFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFinisher.h"
#import "FLPromisedResult.h"
#import "FLWorker.h"

typedef void (^FLCompletionBlock)();

@class FLTimeoutTimer;

@interface FLWorkFinisher : NSObject<FLFinisher, FLPromisedResult> {
@private
    FLTimeoutTimer* _timer;
    BOOL _finished;
    FLResultBlock _finishBlock;
//    FLCompletionBlock _completionBlock;
    FLResult _result;
//    NSThread* _thread;
}

- (id) initWithResultBlock:(FLResultBlock) resultBlock;
+ (id) finisher:(FLResultBlock) completion;
+ (id) finisher;

- (void) startWorker:(id<FLWorker>) worker;

@end

@interface FLMainThreadFinisher : FLWorkFinisher
@end

//@protocol FLAsyncMessage <NSObject>
//- (BOOL) objectWillHandleAsyncMessage:(id) object finisher:(FLWorkFinisher*) finisher;
//@end
//
//@protocol FLAsyncMessageSender <NSObject>
//- (BOOL) sendAsyncMessage:(id<FLAsyncMessage>) message
//          completion:(FLResultBlock) completion;
//@end

#define finisher_(__BLOCK__) [FLWorkFinisher finisher:__BLOCK__]
#define completion_(__BLOCK__) [FLWorkFinisher completion:__BLOCK__]