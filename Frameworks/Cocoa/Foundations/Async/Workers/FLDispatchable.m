//
//  FLDispatchable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatchable.h"

@implementation NSObject (FLDispatchable) 
- (FLFinisher*) startPerforming:(FLCompletionBlock) completion {
    FLFinisher* finisher = [FLFinisher finisher:completion];
    [ ((id)self) performWithFinisher:finisher];
    return finisher;
}

- (FLFinisher*) startPerforming {
    return [self startPerforming:nil];
}

- (id) runSynchronously {
    return [[self startPerforming] waitUntilFinished];
}
@end