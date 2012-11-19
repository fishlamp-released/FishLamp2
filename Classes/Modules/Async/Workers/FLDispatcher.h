//
//  FLDispatcher.h
//  FishLampCore
//
//  Created by Mike Fullerton on 10/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFinisher.h"
#import "FLWorker.h"
#import "FLAsyncBlockWorker.h"
#import "FLBlockWorker.h"

@protocol FLDispatcher <NSObject>

- (FLFinisher*) dispatch:(id<FLWorker>) dispatchable;

- (FLFinisher*) dispatch:(id<FLWorker>) dispatchable
                finisher:(FLFinisher*) finisher;

@end




