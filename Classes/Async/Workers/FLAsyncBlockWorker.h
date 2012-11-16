//
//  FLBlockWorker.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorker.h"


@interface FLAsyncBlockWorker : FLWorker {
@private
    FLAsyncBlock _asyncBlock;
}
- (id) initWithAsyncBlock:(FLAsyncBlock) block;
+ (id) asyncBlockWorker:(FLAsyncBlock) block;
@end

#define async_block_(__BLOCK__) [FLAsyncBlockWorker asyncBlockWorker:__BLOCK__]
