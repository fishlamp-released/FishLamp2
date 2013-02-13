//
//  FLFifoGcdDispatcher.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLGcdDispatcher.h"

@interface FLFifoGcdDispatcher : FLGcdDispatcher
+ (id) fifoDispatchQueue;
+ (FLObjectPool*) pool;
@end

// TODO: make the pool a dispatcher. queue the block get the dispatcher back.