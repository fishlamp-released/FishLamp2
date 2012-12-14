//
//  FLDispatcher.h
//  FLCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFinisher.h"
#import "FLAsyncTask.h"
#import "FLResult.h"


@protocol FLDispatcher <NSObject>

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block;

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block
                   completion:(FLCompletionBlock) completion;

- (FLFinisher*) dispatchAsyncBlock:(FLAsyncFinisherBlock) block;

- (FLFinisher*) dispatchAsyncBlock:(FLAsyncFinisherBlock) block
                       completion:(FLCompletionBlock) completion;


@end


