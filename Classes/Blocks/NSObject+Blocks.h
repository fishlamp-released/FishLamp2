//
//  NSObject+Blocks.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/5/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

@interface NSObject (Blocks)

- (void) performBlockWithDelay:(NSTimeInterval) delay
                         block:(void (^)()) block;

- (void) performBlockOnMainThread:(void (^)()) block;

- (void) performBlockOnMainThreadAndWaitUntilDone:(void (^)()) block;

- (void) performBlock:(void (^)()) block onThread:(NSThread*) thread;

@end

