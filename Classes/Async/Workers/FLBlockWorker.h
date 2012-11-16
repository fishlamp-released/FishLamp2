//
//  FLBlockWorker.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorker.h"

@interface FLBlockWorker : FLWorker {
@private
    FLAsyncBlock _workerBlock;
}
- (id) initWithWorkerBlock:(FLAsyncBlock) block;
+ (id) blockWorker:(FLAsyncBlock) block;

@end
