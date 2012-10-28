//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAsyncWorker.h"
#import "FLSimpleNotifier.h"


@interface FLFinisher : FLSimpleNotifier<FLAsyncResult, FLAsyncFinisher> {
@private
    FLCompletionBlock _completionBlock;
    BOOL _finished;
    NSUInteger _finishCount;
    NSUInteger _expectedFinishCount;
    BOOL _didRunSynchronously;
    id _asyncResult;
    NSError* _error;
}

- (id) initWithCompletionBlock:(FLCompletionBlock) completion;
+ (id) finisher:(FLCompletionBlock) completion;
+ (id) finisher;

- (void) setFinishedWithObject:(id) object;
- (void) setFinishedWithError:(NSError*) error;


@end

//@protocol FLAsyncMessage <NSObject>
//- (BOOL) objectWillHandleAsyncMessage:(id) object finisher:(FLFinisher*) finisher;
//@end
//
//@protocol FLAsyncMessageSender <NSObject>
//- (BOOL) sendAsyncMessage:(id<FLAsyncMessage>) message
//          completion:(FLCompletionBlock) completion;
//@end

