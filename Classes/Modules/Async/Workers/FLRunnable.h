//
//  FLRunnable.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLWorker;

@protocol FLRunnable <NSObject>
- (id) runSynchronously;
- (id) runSynchronouslyWithAsyncTask:(id) asyncTask;
@end

@interface FLRunner : NSObject
+ (id) runWorkerSynchronously:(id<FLWorker>) worker;
+ (id) runWorkerSynchronously:(id<FLWorker>) worker withAsyncTask:(id) asyncTask;
@end