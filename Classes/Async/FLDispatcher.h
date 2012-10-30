//
//  FLDispatcher.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWorkFinisher.h"
#import "FLWorker.h"
#import "FLResult.h"
#import "FLPromisedResult.h"
#import "FLBlockWorker.h"

@protocol FLDispatcher <NSObject>

- (FLPromisedResult) dispatchBlock:(void (^)()) block;

- (FLPromisedResult) dispatchBlock:(void (^)()) block 
                        completion:(FLResultBlock) completion;

- (FLPromisedResult) dispatchAsyncBlock:(FLAsyncBlock) completion;

- (FLPromisedResult) dispatchAsyncBlock:(FLAsyncBlock) block 
                             completion:(FLResultBlock) completion;

- (FLPromisedResult) dispatchWorker:(id<FLWorker>) aWorker;

- (FLPromisedResult) dispatchWorker:(id<FLWorker>) aWorker
                         completion:(FLResultBlock) completion;

@end
