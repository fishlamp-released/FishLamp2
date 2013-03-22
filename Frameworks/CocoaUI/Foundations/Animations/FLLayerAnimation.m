//
//  FLLayerAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLayerAnimation.h"
#import "FLFinisher.h"

@implementation CALayer (FLLayerAnimation)
- (CALayer*) layer {
    return self;
}
@end

@interface FLLayerAnimation ()
@end

@implementation FLLayerAnimation

+ (id) layerAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) prepareLayer:(CALayer*) layer {
}

- (void) commitAnimation:(CALayer*) layer {
}

- (void) finishAnimation:(CALayer*) layer {
}

- (void) startAnimating:(id) target
             completion:(FLBlock) completion {
    
    FLAssertWithComment([NSThread isMainThread], @"not on main thread");

    CALayer* layer = [target layer];
    FLAssertNotNilWithComment(layer, @"layer is nil");
    
    [self startAnimating:^{ [self prepareLayer:layer]; }
                  commit:^{ [self commitAnimation:layer]; }
                  finish:^{ [self finishAnimation:layer]; }
              completion:completion];
}

@end


@implementation FLBatchLayerAnimation 

- (id) init {	
	self = [super init];
	if(self) {
		_animations = [[NSMutableArray alloc] init];
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_animations release];
    [super dealloc];
}
#endif

- (void) prepareLayer:(CALayer*) layer {
    for(FLLayerAnimation* animation in _animations) {
        animation.direction = self.direction;
        [animation prepareLayer:layer];
    }
}

- (void) commitAnimation:(CALayer*) layer {
    for(FLLayerAnimation* animation in _animations) {
        animation.direction = self.direction;
        [animation commitAnimation:layer];
    }
}

- (void) finishAnimation:(CALayer*) layer {
    for(FLLayerAnimation* animation in _animations) {
        animation.direction = self.direction;
        [animation finishAnimation:layer];
    }
}

- (void) addAnimation:(FLLayerAnimation*) animation {
    [_animations addObject:animation];
}

@end
