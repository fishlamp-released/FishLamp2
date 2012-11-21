//
//  FLBlockWorker.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorker.h"

@interface FLBlockWorker : FLWorker {
@private
    dispatch_block_t _block;
}
- (id) initWithBlock:(dispatch_block_t) block;
+ (id) blockWorker:(dispatch_block_t) block;
@end


#define block_ (__BLOCK__) [FLBlockWorker blockWorker:__BLOCK__]