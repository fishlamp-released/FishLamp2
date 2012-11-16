//
//  FLDispatcher.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFinisher.h"
#import "FLWorker.h"
#import "FLBlockWorker.h"

@protocol FLDispatcher <NSObject>

- (FLFinisher*) dispatchBlock:(void (^)()) block;

- (FLFinisher*) dispatchBlock:(void (^)()) block 
                      finisher:(FLFinisher*) finisher;

- (FLFinisher*) dispatchAsyncBlock:(FLAsyncBlock) completion;

- (FLFinisher*) dispatchAsyncBlock:(FLAsyncBlock) block 
                           finisher:(FLFinisher*) finisher;

- (FLFinisher*) dispatchWorker:(id<FLWorker>) aWorker;

- (FLFinisher*) dispatchWorker:(id<FLWorker>) aWorker
                       finisher:(FLFinisher*) finisher;

@end
