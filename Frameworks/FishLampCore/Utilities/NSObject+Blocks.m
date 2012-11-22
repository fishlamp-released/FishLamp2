//
//  NSObject+Blocks.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/5/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "NSObject+Blocks.h"
#import "NSException+NSError.h"
#import "FLAbortException.h"

@implementation NSObject (FLBlocks)

+ (void) _performBlock:(void (^)()) block {
    @try {
        if(block) {
            block();
        }
    }
    @catch(FLAbortException* abortAbortAbort) {
    }
    @catch(NSException* ex) {
        if(!ex.error.isCancelError) {
            @throw;
        }
    
    }
}

- (void) performBlockWithDelay:(NSTimeInterval) delay
                         block:(void (^)()) block {   
    [NSObject performSelector:@selector(_performBlock:) withObject:FLCopyBlock(block) afterDelay:delay];
}

- (void) performBlockOnMainThread:(void (^)()) block  {
    [NSObject performSelectorOnMainThread:@selector(_performBlock:) withObject:FLCopyBlock(block) waitUntilDone:NO];
}

+ (void) performBlockOnMainThread:(void (^)()) block  {
    [NSObject performSelectorOnMainThread:@selector(_performBlock:) withObject:FLCopyBlock(block) waitUntilDone:NO];
}

- (void) performBlockOnMainThreadAndWaitUntilDone:(void (^)()) block {
    [NSObject performSelectorOnMainThread:@selector(_performBlock:) withObject:FLCopyBlock(block) waitUntilDone:YES];
}

- (void) performBlockOnThread:(NSThread*) thread block:(void (^)()) block {
    [NSObject performSelector:@selector(_performBlock:) onThread:thread withObject:FLCopyBlock(block) waitUntilDone:NO];
}

+ (void) performBlockOnThread:(NSThread*) thread block:(void (^)()) block {
    [NSObject performSelector:@selector(_performBlock:) onThread:thread withObject:FLCopyBlock(block) waitUntilDone:NO];
}

@end

