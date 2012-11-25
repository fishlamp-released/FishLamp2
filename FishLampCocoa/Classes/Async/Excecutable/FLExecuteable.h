//
//  FLExecuteable.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLExecuteable <NSObject>
@property (readonly, assign) BOOL wasStarted;
@property (readonly, assign) BOOL isFinished;
@property (readonly, assign) BOOL didFail;
@property (readonly, assign) BOOL didSucceed;

@property (readonly, assign) BOOL didRun;

@property (readonly, strong) NSError* error;
@end

// what will make this operation slow or fail?
typedef enum {
    FLOperationTypeNormal,
    FLOperationTypeDiskBound,
    FLOperationTypeNetworkBound
} FLOperationType;

// hinderance, dependency, etc. condition, environment


// "touched" network, disk, etc.
