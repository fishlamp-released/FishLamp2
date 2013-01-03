//
//  FLBatchAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLBatchAnimation.h"

@interface FLBatchAnimation ()
@end

@implementation FLBatchAnimation

@synthesize cleanup = _cleanup;

#if FL_MRC
- (void) dealloc {
    [_cleanup release];
    [super dealloc];
}
#endif



- (void) setAnimations:(NSArray*) animations 
            completion:(void (^)()) completion {
    
    FLAssertNotNil_(animations);

    FLSafeguardBlock(completion);

    FLAnimationBlock cleanup = FLSetProperty(self.cleanup, nil);

    self.prepare = ^(id batch) {

        for(FLAnimation* animation in animations) {
            if(animation.prepare) {
                animation.prepare(animation);
            }
        }
        
        self.commit = ^{
            for(FLAnimation* animation in animations) {
                if(animation.commit) {
                    animation.commit();
                }
            }
        };
        
        self.finish = ^{
            for(FLAnimation* animation in animations) {
                if(animation.finish) {
                    animation.finish();
                }
            }
            
            if(cleanup) {
                cleanup();
            }
            
            if(completion) {
                completion();
            }
        };           
    };
}

- (void) setAnimations:(NSArray*) animations {
    [self setAnimations:animations completion:nil];
}




@end
