//
//  FLRotateAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLRotateAnimation.h"

//@implementation FLRotateAnimation
////CGFloat GetNextDegree(CGFloat inDegree, CGFloat increment) {
////
////    CGFloat degree = inDegree + increment;
////
////    if(degree >= 360.0f) {
////        degree = 360.0f - degree;
////    }
////    else if(degree < 0.0) {
////        degree = 360.0f + degree;
////        
////    }
////
////    FLLog(@"next: %f, prev: %f", degree, inDegree);
////
////    return degree;
////}
//
////- (void) somersault;
////{
////
////    CALayer* layer = [self layer];
////    NSMutableArray* keyFrameValues = [NSMutableArray array];
////    [keyFrameValues addObject:[NSNumber numberWithFloat:0.0]];
////    //[values addObject:[NSNumber numberWithFloat:M_PI*0.5]];
////    [keyFrameValues addObject:[NSNumber numberWithFloat:M_PI]];
////    [keyFrameValues addObject:[NSNumber numberWithFloat:M_PI*1.5]];
////    [keyFrameValues addObject:[NSNumber numberWithFloat:M_PI*2.0]];
////
////    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
////    [animation setValues:keyFrameValues];
////    [animation setValueFunction:[CAValueFunction functionWithName: kCAValueFunctionRotateX]];// kCAValueFunctionRotateZ]];
////
////    [animation setDuration:0.9];
////    //[animation setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
////
////    [layer addAnimation:animation forKey:nil];
////
////    return;
////}
//
//- (CAAnimation*) CAAnimation:(FLAnimationFlags) flags {
//    CABasicAnimation *rotationAnimation =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]; //Rotate about z-axis
//    [rotationAnimation setFromValue:[NSNumber numberWithFloat:FLDegreesToRadians(_fromDegree)]];
//    [rotationAnimation setToValue:[NSNumber numberWithFloat:FLDegreesToRadians(_toDegree)]];
//    
////    [rotationAnimation setByValue:[NSNumber numberWithFloat:FLDegreesToRadians(_deltaAmount)]];
//    [rotationAnimation setDuration:4.0];
//    rotationAnimation.cumulative = NO;
//    [rotationAnimation setRemovedOnCompletion:YES];
////    [rotationAnimation setFillMode:kCAFillModeForwards];
//    return rotationAnimation;
//}
//
//- (void) commitAnimation:(CALayer*) layer withAnimationFlags:(FLAnimationFlags) flags {
//    [layer addAnimation:[self CAAnimation:flags] forKey:@"transform.rotation.z"];
//}
//
//- (void) startRotating:(id) target 
//        startFlags:(FLAnimationStartFlags) startFlags
//            fromDegree:(CGFloat) from 
//              toDegree:(CGFloat) toDegree 
//            completion:(FLBlock) completion {
//    _fromDegree = from;
//    _toDegree = toDegree;
//    
//    FLLog(@"Start rotating: from %f to %f", _fromDegree, _toDegree);
//    
//    [self startAnimating:target startFlags:startFlags completion:completion];
//}            
//
//- (void) startRotating:(id) target 
//       degreesToRotate:(CGFloat) degrees 
//            completion:(FLBlock) completion {
//    
//    _deltaAmount = degrees;
//    
//    FLLog(@"Start rotating by degrees: %f", _deltaAmount);
//    
//    [self startAnimating:target completion:completion];
//            
//}            
//
//
//@end

@implementation FLSomersaultAnimation

- (NSArray*) forwardKeyFrames {

    static NSMutableArray* s_frames = nil;
    if(!s_frames) {
        s_frames = [[NSMutableArray alloc] init];
        [s_frames addObject:[NSNumber numberWithFloat:M_PI*2.0]];
        [s_frames addObject:[NSNumber numberWithFloat:M_PI*1.5]];
        [s_frames addObject:[NSNumber numberWithFloat:M_PI]];
        [s_frames addObject:[NSNumber numberWithFloat:M_PI*0.5]];
        [s_frames addObject:[NSNumber numberWithFloat:0.0]];

//        [s_frames addObject:[NSNumber numberWithFloat:M_PI]];
    }
    return s_frames;
}

- (NSArray*) backwardKeyFrames {
    static NSMutableArray* s_frames = nil;
    if(!s_frames) {
        s_frames = [[NSMutableArray alloc] init];
        [s_frames addObject:[NSNumber numberWithFloat:0.0]];
        [s_frames addObject:[NSNumber numberWithFloat:M_PI*0.5]];
        [s_frames addObject:[NSNumber numberWithFloat:M_PI]];
        [s_frames addObject:[NSNumber numberWithFloat:M_PI*1.5]];
        [s_frames addObject:[NSNumber numberWithFloat:M_PI*2.0]];
    }
    return s_frames;
}

- (void) commitAnimation:(CALayer *)layer {

    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [animation setValues:self.direction == FLAnimationDirectionRight ? [self forwardKeyFrames]  : [self backwardKeyFrames]];
    
    NSString* axis = nil;
    switch(self.axis) {
        case FLAnimationAxisX:
            axis = kCAValueFunctionRotateX;
            break;
        case FLAnimationAxisY:
            axis = kCAValueFunctionRotateY;
            break;
        case FLAnimationAxisZ:
            axis = kCAValueFunctionRotateZ;
            break;
    }
    
    [animation setValueFunction:[CAValueFunction functionWithName: axis]];
    [self configureAnimation:animation];
    [layer addAnimation:animation forKey:nil];
}

@end

//   if (rec.state == UIGestureRecognizerStateChanged) {
//        CGAffineTransform currentTransform = squareLayer.affineTransform;
//        squareLayer.affineTransform = CGAffineTransformRotate(currentTransform, gesture.rotation);
//        gesture.rotation = 0;
//    }

/*
CABasicAnimation *rotationAnimation =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]; //Rotate about z-axis
[rotationAnimation setFromValue:[NSNumber numberWithFloat:fromDegree]];
[rotationAnimation setToValue:[NSNumber numberWithFloat:toDegree]];
[rotationAnimation setDuration:0.2];
[rotationAnimation setRemovedOnCompletion:YES];
[rotationAnimation setFillMode:kCAFillModeForwards];

*/



/*
CALayer *layer = rotatingImage.layer;
CAKeyframeAnimation *animation;
animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
animation.duration = 0.5f;
animation.cumulative = YES;
animation.repeatCount = 1;
animation.values = [NSArray arrayWithObjects:   	// i.e., Rotation values for the 3 keyframes, in RADIANS
	  [NSNumber numberWithFloat:0.0 * M_PI], 
	  [NSNumber numberWithFloat:0.75 * M_PI], 
	  [NSNumber numberWithFloat:1.5 * M_PI], nil]; 
animation.keyTimes = [NSArray arrayWithObjects:     // Relative timing values for the 3 keyframes
	  [NSNumber numberWithFloat:0], 
	  [NSNumber numberWithFloat:.5], 
	  [NSNumber numberWithFloat:1.0], nil]; 
animation.timingFunctions = [NSArray arrayWithObjects:
	  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],	// from keyframe 1 to keyframe 2
	  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], nil];	// from keyframe 2 to keyframe 3
animation.removedOnCompletion = NO;
animation.fillMode = kCAFillModeForwards;

[layer addAnimation:animation forKey:nil];
*/

/*
CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
	if (direction == ROTATE_FROM_LEFT) {
		rotation.values = [NSArray arrayWithObjects:
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.0f, 0.0f, 1.0f, 0.0f)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0f, 1.0f, 0.0f)],nil];
	} else if (direction == ROTATE_FROM_RIGHT) {
		rotation.values = [NSArray arrayWithObjects:
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0f, 1.0f, 0.0f)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.0f, 0.0f, 1.0f, 0.0f)],nil];
	} else {
		rotation.values = [NSArray arrayWithObjects:
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.0f, 0.0f, 1.0f, 0.0f)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0f, 1.0f, 0.0f)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * 2, 0.0f, 1.0f, 0.0f)],nil];
		duration *= 2;
	}
	
	rotation.duration = duration;
	rotation.delegate = self;
	
	[[self layer] addAnimation:rotation forKey:@"transform"];
*/