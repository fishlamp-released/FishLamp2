//
//  FLWorker.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"

#import "FLFinisher.h"
#import "FLFallible.h"
#import "FLAsyncTask.h"

@protocol FLWorker <NSObject>
@optional 
- (void) didMoveToParentWorker:(id) parent;
@property (readonly, assign) id parentWorker;
@end


@interface FLWorker : NSObject<FLFallible, FLWorker> {
@private
    __unsafe_unretained id _parentWorker;
    __unsafe_unretained id _errorDelegate;
}
@property (readonly, assign) id parentWorker;

- (void) willAddWorker:(id<FLWorker>) worker;
- (void) willRemoveWorker:(id<FLWorker>) worker;

@end

