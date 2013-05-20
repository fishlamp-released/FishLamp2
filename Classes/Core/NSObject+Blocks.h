//
//  NSObject+Blocks.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

typedef void (^GtBlock)();

@interface NSObject (Blocks)

- (void) performBlockWithDelay:(NSTimeInterval) delay
                         block:(GtBlock) block;

- (void) performBlockOnMainThread:(GtBlock) block;

- (void) performBlockOnMainThreadAndWaitUntilDone:(GtBlock) block;

- (void) performBlock:(GtBlock) block onThread:(NSThread*) thread;

@end

