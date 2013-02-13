//
//  NSObject+Blocks.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/5/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLRequired.h"

@interface NSObject (Blocks)

- (void) performBlockWithDelay:(NSTimeInterval) delay
                         block:(void (^)()) block;

- (void) performBlockOnMainThread:(void (^)()) block;

- (void) performBlockOnMainThreadAndWaitUntilDone:(void (^)()) block;

- (void) performBlockOnThread:(NSThread*) thread block:(void (^)()) block;


+ (void) performBlockOnMainThread:(void (^)()) block;

+ (void) performBlockOnThread:(NSThread*) thread block:(void (^)()) block;


@end

typedef void (^FLBlock)();
typedef void (^FLBlockWithError)(NSError* error);