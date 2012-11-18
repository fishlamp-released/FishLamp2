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
    FLAsyncTaskBlock _asyncBlock;
}
- (id) initWithAsyncTaskBlock:(FLAsyncTaskBlock) block;
+ (id) asyncBlockWorker:(FLAsyncTaskBlock) block;
@end

