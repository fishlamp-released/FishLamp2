//
//  FLWorkerQueue.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorker.h"

@interface FLWorkerQueue : FLWorker {
@private
    NSMutableArray* _workers;
 }

@property (readonly, strong) NSArray* workers;

- (void) addWorker:(id<FLWorker>) worker;

@end
