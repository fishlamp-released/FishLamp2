//
//  FLDispatcher.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFinisher.h"
#import "FLAsyncTask.h"

@protocol FLDispatcher <NSObject>

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block;

- (FLFinisher*) dispatchBlock:(dispatch_block_t) block
                     finisher:(FLFinisher*) finisher;

- (FLFinisher*) dispatch:(FLAsyncTaskBlock) block;

- (FLFinisher*) dispatch:(FLAsyncTaskBlock) block
                finisher:(FLFinisher*) finisher;


@end




