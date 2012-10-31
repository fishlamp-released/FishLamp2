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

- (id<FLPromisedResult>) dispatchBlock:(void (^)()) block;

- (id<FLPromisedResult>) dispatchBlock:(void (^)()) block 
                        completion:(FLResultBlock) completion;

- (id<FLPromisedResult>) dispatchAsyncBlock:(FLAsyncBlock) completion;

- (id<FLPromisedResult>) dispatchAsyncBlock:(FLAsyncBlock) block 
                             completion:(FLResultBlock) completion;

- (id<FLPromisedResult>) dispatchWorker:(id<FLWorker>) aWorker;

- (id<FLPromisedResult>) dispatchWorker:(id<FLWorker>) aWorker
                         completion:(FLResultBlock) completion;

@end
