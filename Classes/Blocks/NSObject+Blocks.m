//
//  NSObject+Blocks.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/5/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "NSObject+Blocks.h"
#import "FLErrors.h"
#import "FLExceptions.h"

@implementation NSObject (FLBlocks)

- (void) _performBlock:(void (^)()) block {
    @try {
        if(block) {
            block();
        }
    }
    @catch(NSException* ex) {
        if(!ex.error.isCancelError) {
//            FLLog(@"Uncaught exception in thread: %@", [ex description]);
            @throw;
        }
    }
}

- (void) performBlockWithDelay:(NSTimeInterval) delay
                         block:(void (^)()) block {   
    [self performSelector:@selector(_performBlock:) withObject:FLReturnAutoreleased([block copy]) afterDelay:delay];
}

- (void) performBlockOnMainThread:(void (^)()) block  {
    [self performSelectorOnMainThread:@selector(_performBlock:) withObject:FLReturnAutoreleased([block copy]) waitUntilDone:NO];
}

- (void) performBlockOnMainThreadAndWaitUntilDone:(void (^)()) block {
    [self performSelectorOnMainThread:@selector(_performBlock:) withObject:FLReturnAutoreleased([block copy]) waitUntilDone:YES];
}

- (void) performBlock:(void (^)()) block onThread:(NSThread*) thread {
    [self performSelector:@selector(_performBlock:) onThread:thread withObject:FLReturnAutoreleased([block copy]) waitUntilDone:NO];
}
@end

