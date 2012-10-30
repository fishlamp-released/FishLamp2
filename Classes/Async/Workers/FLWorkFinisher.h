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

@class FLTimeoutTimer;

@interface FLWorkFinisher : NSObject<FLFinisher, FLPromisedResult> {
@private
    FLTimeoutTimer* _timer;
    BOOL _finished;
    FLResultBlock _completionBlock;
    FLResult _result;
}

- (id) initWithCompletionBlock:(FLResultBlock) completion;
+ (id) finisher:(FLResultBlock) completion;
+ (id) finisher;

@end

//@protocol FLAsyncMessage <NSObject>
//- (BOOL) objectWillHandleAsyncMessage:(id) object finisher:(FLWorkFinisher*) finisher;
//@end
//
//@protocol FLAsyncMessageSender <NSObject>
//- (BOOL) sendAsyncMessage:(id<FLAsyncMessage>) message
//          completion:(FLResultBlock) completion;
//@end


