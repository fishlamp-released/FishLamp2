//
//  NSObject+Blocks.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSObject+Blocks.h"
#import "NSException+GtExtras.h"

@implementation NSObject (GT_Blocks)

- (void) _performBlock:(GtBlock) block {
    @try {
        if(block) {
            block();
        }
    }
    @catch(NSException* ex) {
        if(!ex.error.isCancelError) {
            GtLog(@"Uncaught exception in thread: %@", [ex description]);
            @throw;
        }
    }
}

- (void) performBlockWithDelay:(NSTimeInterval) delay
                         block:(GtBlock) block {   
    [self performSelector:@selector(_performBlock:) withObject:GtReturnAutoreleased([block copy]) afterDelay:delay];
}

- (void) performBlockOnMainThread:(GtBlock) block  {
    [self performSelectorOnMainThread:@selector(_performBlock:) withObject:GtReturnAutoreleased([block copy]) waitUntilDone:NO];
}

- (void) performBlockOnMainThreadAndWaitUntilDone:(GtBlock) block {
    [self performSelectorOnMainThread:@selector(_performBlock:) withObject:GtReturnAutoreleased([block copy]) waitUntilDone:YES];
}

- (void) performBlock:(GtBlock) block onThread:(NSThread*) thread {
    [self performSelector:@selector(_performBlock:) onThread:thread withObject:GtReturnAutoreleased([block copy]) waitUntilDone:NO];
}
@end

