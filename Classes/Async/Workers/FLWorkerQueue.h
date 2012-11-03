//
//  FLWorkerQueue.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSimpleWorker.h"

@interface FLWorkerQueue : FLSimpleWorker {
@private
    NSMutableArray* _queue;
}

@property (readonly, strong) NSArray* workers;

- (void) addWorker:(id<FLWorker>) worker;

@end
