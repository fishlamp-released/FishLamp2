//
//  FLDispatchable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

@protocol FLAsyncQueue;
@protocol FLPromisedResult;

@class FLFinisher;

@protocol FLDispatchable <NSObject>
- (FLFinisher*) willStartInQueue:(id<FLAsyncQueue>) queue;
- (void) startInQueue:(id<FLAsyncQueue>) queue;

- (id<FLPromisedResult>) runSynchronouslyInQueue:(id<FLAsyncQueue>) asyncQueue;
@end