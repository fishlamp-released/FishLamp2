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
@property (readwrite, strong, nonatomic) CALayer* layer;
@end

@implementation FLLayerAnimation

@synthesize layer = _layer;

+ (id) layerAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_layer release];
    [super dealloc];
}
#endif

- (void) prepareLayer:(CALayer*) layer {
}

- (void) commitAnimation:(CALayer*) layer {
}

- (void) finishAnimation:(CALayer*) layer {
}

- (void) begin {
    [self prepareLayer:self.layer];
}

- (void) willFinish {
    [self finishAnimation:self.layer];
}

- (void) commit {
    [self commitAnimation:self.layer];
}

- (void) startAnimating:(id) target
             completion:(FLAnimationCompletionBlock) completion {
    
    FLAssertWithComment([NSThread isMainThread], @"not on main thread");

    self.layer = [target layer];
    FLAssertNotNilWithComment(_layer, @"layer is nil");
    
    [self startAnimating:FLCopyWithAutorelease(completion)];
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

- (void) begin {
    for(FLLayerAnimation* animation in _animations) {
        [animation begin];
    }
}

- (void) willFinish {
    for(FLLayerAnimation* animation in _animations) {
        [animation willFinish];
    }
}

- (void) commit {
    for(FLLayerAnimation* animation in _animations) {
        [animation commit];
    }
}

- (void) addAnimation:(FLLayerAnimation*) animation {
    [_animations addObject:animation];
}

@end
