//
//  NSObject+Blocks.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/5/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLObjc.h"

@interface NSObject (Blocks)

- (void) performBlockWithDelay:(NSTimeInterval) delay
                         block:(void (^)()) block;

- (void) performBlockOnMainThread:(void (^)()) block;

- (void) performBlockOnMainThreadAndWaitUntilDone:(void (^)()) block;

- (void) performBlockOnThread:(NSThread*) thread block:(void (^)()) block;


+ (void) performBlockOnMainThread:(void (^)()) block;

+ (void) performBlockOnThread:(NSThread*) thread block:(void (^)()) block;


@end

