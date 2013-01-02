//
//  FLDispatchable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatchable.h"

@implementation NSObject (FLDispatchable) 
- (id) runSynchronously {
    FLFinisher* finisher = [FLFinisher finisher];
    [ ((id)self) startWorking:finisher];
    return [finisher waitUntilFinished];
}
@end