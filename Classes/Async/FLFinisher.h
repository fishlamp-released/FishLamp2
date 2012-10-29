//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWorker.h"
@class FLTimeoutTimer;

@interface FLFinisher : NSObject<FLFinisher, FLResultPromise> {
@private
    FLTimeoutTimer* _timer;
    BOOL _finished;
    FLCompletionBlock _completionBlock;
    id<FLResult> _result;
}

- (id) initWithCompletionBlock:(FLCompletionBlock) completion;
+ (id) finisher:(FLCompletionBlock) completion;
+ (id) finisher;

@end

//@protocol FLAsyncMessage <NSObject>
//- (BOOL) objectWillHandleAsyncMessage:(id) object finisher:(FLFinisher*) finisher;
//@end
//
//@protocol FLAsyncMessageSender <NSObject>
//- (BOOL) sendAsyncMessage:(id<FLAsyncMessage>) message
//          completion:(FLCompletionBlock) completion;
//@end

