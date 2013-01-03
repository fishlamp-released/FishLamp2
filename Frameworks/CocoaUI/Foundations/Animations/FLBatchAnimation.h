//
//  FLBatchAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"
#import "NSArray+FLExtras.h"

@interface FLBatchAnimation : FLAnimation {
@private
    FLAnimationBlock _cleanup;
}

@property (readwrite, copy, nonatomic) FLAnimationBlock cleanup;

- (void) setAnimations:(NSArray*) animations 
            completion:(void (^)()) completion;

- (void) setAnimations:(NSArray*) animations;


@end
