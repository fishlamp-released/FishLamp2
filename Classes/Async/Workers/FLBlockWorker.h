//
//  FLBlockWorker.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLSimpleWorker.h"

typedef void (^FLWorkerBlock)(FLFinisher finisher);

@interface FLBlockWorker : FLSimpleWorker {
@private
    FLWorkerBlock _workerBlock;
}
- (id) initWithWorkerBlock:(FLWorkerBlock) block;
+ (id) blockWorker:(FLWorkerBlock) block;

@end
