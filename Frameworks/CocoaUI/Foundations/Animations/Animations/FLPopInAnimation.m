//
//  FLPopInAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/4/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPopInAnimation.h"

@implementation FLPopInAnimation

+ (CAAnimation*) animationForLayer:(CALayer *) layer {
    
    CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
	
    popInAnimation.values = [NSArray arrayWithObjects:
							 [NSNumber numberWithFloat:0.6],
							 [NSNumber numberWithFloat:1.1],
							 [NSNumber numberWithFloat:.9],
							 [NSNumber numberWithFloat:1],
							 nil];
	
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
							   [NSNumber numberWithFloat:0.0],
							   [NSNumber numberWithFloat:0.6],
							   [NSNumber numberWithFloat:0.8],
							   [NSNumber numberWithFloat:1.0], 
							   nil];	
    return popInAnimation;
}

- (void) setTarget:(id) target {
    self.prepare = ^(id animation){
        self.commit = ^{
            CALayer* layer = [self layerFromTarget:target];
            [layer addAnimation:[FLPopInAnimation animationForLayer:layer] forKey:@"transform.scale"];    
        };
    };
}
@end
