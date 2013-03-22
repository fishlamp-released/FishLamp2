//
//  FLLayerAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//


#import "FLAnimation.h"

@interface FLLayerAnimation : FLAnimation {
}

+ (id) layerAnimation;

- (void) startAnimating:(id) target
             completion:(FLBlock) completion;

// overrides
// animations are disabled during prepare and finish,
// commit is where you apply the animations
- (void) prepareAnimation:(CALayer*) layer;
- (void) commitAnimation:(CALayer*) layer;
- (void) finishAnimation:(CALayer*) layer;
@end

@interface FLBatchLayerAnimation : FLLayerAnimation {
@private
    NSMutableArray* _animations;
}

//// use this to add child animations
- (void) addAnimation:(FLLayerAnimation*) animation;

@end
