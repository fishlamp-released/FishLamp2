//
//  FLAsyncQueue+AsyncWorker.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncQueue.h"

@interface FLAsyncQueue (AsyncWorker)

- (FLFinisher*) queueAsyncWorker:(id<FLAsyncWorker>) worker;

- (FLFinisher*) queueAsyncWorker:(id<FLAsyncWorker>) worker 
                  completion:(FLBlockWithResult) completion;

@end


