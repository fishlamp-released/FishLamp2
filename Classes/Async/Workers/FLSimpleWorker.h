//
//  FLSimpleWorker.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWorker.h"

@interface FLSimpleWorker : NSObject<FLWorkerParent, FLRunnable> {
@private
    __unsafe_unretained id _parentWorker;
    __unsafe_unretained id _errorDelegate;
}

@end
