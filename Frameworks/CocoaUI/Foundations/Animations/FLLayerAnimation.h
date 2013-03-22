//
//  FLLayerAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//


#import "FLAnimation.h"

@interface FLLayerAnimation : FLAnimation {
@private
    CALayer* _layer;
}

@property (readonly, strong, nonatomic) CALayer* layer;

+ (id) layerAnimation;

- (void) startAnimating:(id) target
             completion:(FLAnimationCompletionBlock) completion;

// overrides
// animations are disabled during prepare and finish,
// commit is where you apply the animations
- (void) prepareLayer:(CALayer*) layer;
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
