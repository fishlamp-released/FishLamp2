//
//  FLDispatchable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLPromisedResult.h"

@protocol FLAsyncQueue;

@class FLFinisher;

@protocol FLDispatchable <NSObject>
- (FLFinisher*) asyncQueueWillBeginAsync:(id<FLAsyncQueue>) asyncQueue;
- (void) asyncQueue:(id<FLAsyncQueue>) asyncQueue beginAsyncWithFinisher:(FLFinisher*) finisher;

- (FLPromisedResult) runSynchronouslyInAsyncQueue:(id<FLAsyncQueue>) asyncQueue;
@end