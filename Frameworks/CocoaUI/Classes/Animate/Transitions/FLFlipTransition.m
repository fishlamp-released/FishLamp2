//
//  FLFlipAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

// see http://www.mentalfaculty.com/mentalfaculty/Blog/Entries/2010/9/22_FLIPPIN_OUT_AT_NSVIEW.html

#import "FLFlipTransition.h"

@implementation CAAnimation (Flip)
//
//+(CAAnimation *)flipAnimationWithDuration:(NSTimeInterval)aDuration 
//                   forLayerBeginningOnTop:(BOOL)beginsOnTop 
//                              scaleFactor:(CGFloat)scaleFactor {    
//
//    // Rotating halfway (pi radians) around the Y axis gives the appearance of flipping
//    CABasicAnimation *flipAnimation = 
//        [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    CGFloat startValue = beginsOnTop ? 0.0f : M_PI;
//    CGFloat endValue = beginsOnTop ? -M_PI : 0.0f;
//    flipAnimation.fromValue = [NSNumber numberWithDouble:startValue];
//    flipAnimation.toValue = [NSNumber numberWithDouble:endValue];
//    
//    // Shrinking the view makes it seem to move away from us, for a more natural effect
//    // Can also grow the view to make it move out of the screen
//    CABasicAnimation *shrinkAnimation = nil;
//    if ( scaleFactor != 1.0f ) {
//        shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        shrinkAnimation.toValue = [NSNumber numberWithFloat:scaleFactor];
//        
//        // We only have to animate the shrink in one direction, then use autoreverse to "grow"
//        shrinkAnimation.duration = aDuration * 0.5;
//        shrinkAnimation.autoreverses = YES;
//    }
//    
//    // Combine the flipping and shrinking into one smooth animation
//    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
//    animationGroup.animations = [NSArray arrayWithObjects:flipAnimation, shrinkAnimation, nil];
//    
//    // As the edge gets closer to us, it appears to move faster. 
//    // Simulate this in 2D with an easing function
//    animationGroup.timingFunction = 
//        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animationGroup.duration = aDuration;
//    
//    // Hold the view in the state reached
//    animationGroup.fillMode = kCAFillModeForwards;
//    animationGroup.removedOnCompletion = NO;
//    
//    return animationGroup;
//}


+(CAAnimation *)flipAnimationWithDuration:(NSTimeInterval)aDuration forLayerBeginningOnTop:(BOOL)beginsOnTop scaleFactor:(CGFloat)scaleFactor {    
    // Rotating halfway (pi radians) around the Y axis gives the appearance of flipping
    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    CGFloat startValue = beginsOnTop ? 0.0f : M_PI;
    CGFloat endValue = beginsOnTop ? -M_PI : 0.0f;
    flipAnimation.fromValue = [NSNumber numberWithDouble:startValue];
    flipAnimation.toValue = [NSNumber numberWithDouble:endValue];
    
    // Shrinking the view makes it seem to move away from us, for a more natural effect
    // Can also grow the view to make it move out of the screen
    CABasicAnimation *shrinkAnimation = nil;
    if ( scaleFactor != 1.0f ) {
        shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shrinkAnimation.toValue = [NSNumber numberWithFloat:scaleFactor];
        
        // We only have to animate the shrink in one direction, then use autoreverse to "grow"
        shrinkAnimation.duration = aDuration * 0.5;
        shrinkAnimation.autoreverses = YES;
    }
    
    // Combine the flipping and shrinking into one smooth animation
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:flipAnimation, shrinkAnimation, nil];
    
    // As the edge gets closer to us, it appears to move faster. Simulate this in 2D with an easing function
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.duration = aDuration;
    
    // Hold the view in the state reached by the animation until we can fix it, or else we get an annoying flicker
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    
    return animationGroup;
}

@end

@implementation NSView (Flip)

-(CALayer *)layerFromContents
{
    CALayer *newLayer = [CALayer layer];
    newLayer.bounds = self.bounds;
    NSBitmapImageRep *bitmapRep = [self bitmapImageRepForCachingDisplayInRect:self.bounds];
    [self cacheDisplayInRect:self.bounds toBitmapImageRep:bitmapRep];
    newLayer.contents = (id)bitmapRep.CGImage;
    return newLayer;
}

@end

@implementation FLFlipTransition

@synthesize perspectiveDistance = _perspectiveDistance;

- (id) initWithDirection:(FLAnimationDirection) direction {
               
    self = [super init];
    if(self) {
        _perspectiveDistance = FLFlipAnimationDefaultPerspectiveDistance;
        self.duration = .75;
        
        self.axis = FLAnimationAxisX;

//        FLFlipAnimation* show = [FLFlipAnimation flipAnimation:direction];
//        show.showBothSidesDuringFlip = NO;
//        show.perspectiveDistance = _perspectiveDistance;
//        self.showAnimation = show;
//
//        FLFlipAnimation* hide = [FLFlipAnimation flipAnimation:FLAnimationDirectionGetOppositeDirection(direction)];
//        hide.showBothSidesDuringFlip = NO;
//        hide.perspectiveDistance = _perspectiveDistance;
//        self.hideAnimation = hide;
    }
    
    return self;
}

+ (id) flipTransition:(FLAnimationDirection) animationDirection {
    return FLAutorelease([[[self class] alloc] initWithDirection:animationDirection]);
}

- (void) prepareTransition:(CALayer *)showLayer hideLayer:(CALayer *)hideLayer {

}

- (void) startShowingView:(SDKView*) bottomView 
               viewToHide:(SDKView*) topView
               completion:(FLBlock) completion {
    
//    if ( isFlipped ) {
//        topView = backView;
//        bottomView = frontView;
//    }
//    else {
//        topView = frontView;
//        bottomView = backView;
//    }
    
    NSView* hostView = bottomView.superview;

    [bottomView removeFromSuperview];
    
    CAAnimation *topAnimation = 
        [CAAnimation flipAnimationWithDuration:self.duration forLayerBeginningOnTop:YES 
            scaleFactor:1.0f];
    CAAnimation *bottomAnimation = 
        [CAAnimation flipAnimationWithDuration:self.duration forLayerBeginningOnTop:NO 
            scaleFactor:1.0f];
    
    bottomView.frame = topView.frame;
    CALayer* topLayer = [topView layerFromContents];
    CALayer* bottomLayer = [bottomView layerFromContents];
    
    CGFloat zDistance = 1500.0f;
    CATransform3D perspective = CATransform3DIdentity; 
    perspective.m34 = -1. / zDistance;
    topLayer.transform = perspective;
    bottomLayer.transform = perspective;
    
    bottomLayer.frame = topView.frame;
    bottomLayer.doubleSided = NO;
    [hostView.layer addSublayer:bottomLayer];
    
    topLayer.doubleSided = NO;
    topLayer.frame = topView.frame;
    [hostView.layer addSublayer:topLayer];
    
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];
    [topView removeFromSuperview];
    [CATransaction commit];
    
    completion = FLCopyWithAutorelease(completion);
    
    [CATransaction setCompletionBlock:^{
//        isFlipped = !isFlipped;
        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];
        [hostView addSubview:bottomView];
        [topLayer removeFromSuperlayer];
        [bottomLayer removeFromSuperlayer];
//        topLayer = nil; bottomLayer = nil;
        [CATransaction commit];
    
        if(completion) {
            completion();
        }
    }];

    
    [CATransaction begin];
    [topLayer addAnimation:topAnimation forKey:@"flip"];
    [bottomLayer addAnimation:bottomAnimation forKey:@"flip"];
    [CATransaction commit];
}  


//- (NSArray*) forwardKeyFrames {
//
//    static NSMutableArray* s_frames = nil;
//    if(!s_frames) {
//        s_frames = [[NSMutableArray alloc] init];
//        [s_frames addObject:[NSNumber numberWithFloat:M_PI*2.0]];
//        [s_frames addObject:[NSNumber numberWithFloat:M_PI*1.5]];
//        [s_frames addObject:[NSNumber numberWithFloat:M_PI]];
////        [s_frames addObject:[NSNumber numberWithFloat:M_PI*0.5]];
////        [s_frames addObject:[NSNumber numberWithFloat:0.0]];
//
////        [s_frames addObject:[NSNumber numberWithFloat:M_PI]];
//    }
//    return s_frames;
//}
//
//- (NSArray*) backwardKeyFrames {
//    static NSMutableArray* s_frames = nil;
//    if(!s_frames) {
//        s_frames = [[NSMutableArray alloc] init];
//        [s_frames addObject:[NSNumber numberWithFloat:0.0]];
//        [s_frames addObject:[NSNumber numberWithFloat:M_PI*0.5]];
//        [s_frames addObject:[NSNumber numberWithFloat:M_PI]];
////        [s_frames addObject:[NSNumber numberWithFloat:M_PI*1.5]];
////        [s_frames addObject:[NSNumber numberWithFloat:M_PI*2.0]];
//    }
//    return s_frames;
//}
//
//- (void) adjustLayer:(CALayer*) layer {
//    CGRect frame = layer.frame;
//    CGPoint newPosition = layer.position;
//    newPosition.y += (frame.size.height/ 2);
//    newPosition.x += (frame.size.width / 2);
//    layer.anchorPoint = CGPointMake(0.5, 0.5);
//    layer.position = newPosition;
//    layer.doubleSided = NO;
//    
//}
//
//- (void) prepareTransition:(CALayer*) showLayer hideLayer:(CALayer*) hideLayer {
//
//    _topPosition = showLayer.position;
//    _topAnchor = showLayer.anchorPoint;
//    _bottomPosition = hideLayer.position;
//    _bottomAnchor = hideLayer.anchorPoint;
//    _topTransform = showLayer.transform;
//    _bottomTransform = hideLayer.transform;
//
//    hideLayer.hidden = YES;
//    
//    [self adjustLayer:showLayer];
// //   [self adjustLayer:hideLayer];
//
////    showLayer.doubleSided = NO;
//
////    switch(self.axis) {
////        case FLAnimationAxisX:
////            showLayer.transform = CATransform3DScale(CATransform3DMakeRotation(M_PI / 2.0f, 1,0,0), -1, 1, 1);
////            break;
////        case FLAnimationAxisY:
//            showLayer.transform = CATransform3DScale(CATransform3DMakeRotation(M_PI / 2.0f, 0,1,0), 1, -1, 1);
////            break;
////        case FLAnimationAxisZ:
////            showLayer.transform = CATransform3DScale(CATransform3DMakeRotation(M_PI / 2.0f, 0,0,1), 1, 1, -1);
////            break;
////    }
//
//}
//
//- (void) configureAnimation:(CAKeyframeAnimation*) animation {
//    NSString* axis = nil;
//    switch(self.axis) {
//        case FLAnimationAxisX:
//            axis = kCAValueFunctionRotateX;
//            break;
//        case FLAnimationAxisY:
//            axis = kCAValueFunctionRotateY;
//            break;
//        case FLAnimationAxisZ:
//            axis = kCAValueFunctionRotateZ;
//            break;
//    }
//    animation.additive = YES;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeBoth;
//    
//    [animation setValueFunction:[CAValueFunction functionWithName: axis]];
//    [super configureAnimation:animation];
//}
//
//- (void) commitTransition:(CALayer*) showLayer hideLayer:(CALayer*) hideLayer  {
//
//    CAKeyframeAnimation* topAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    [topAnimation setValues:self.direction == FLAnimationDirectionRight ? [self forwardKeyFrames]  : [self backwardKeyFrames]];
//
//    CAKeyframeAnimation* bottomAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    [bottomAnimation setValues:self.direction == FLAnimationDirectionRight ? [self backwardKeyFrames] : [self forwardKeyFrames]];
//
//    [self configureAnimation:topAnimation];
//    [self configureAnimation:bottomAnimation];
//    
//    [showLayer addAnimation:topAnimation forKey:@"transform"];
// //   [hideLayer addAnimation:bottomAnimation forKey:@"transform"];
//}
//
//- (void) finishTransition:(CALayer*) showLayer hideLayer:(CALayer*) hideLayer {
//    hideLayer.hidden = YES;
//    showLayer.position = _topPosition;
//    showLayer.anchorPoint = _topAnchor;
//    hideLayer.position = _bottomPosition;
//    hideLayer.anchorPoint = _bottomAnchor;
//    
//    showLayer.hidden = NO;
//    
//    showLayer.transform = _topTransform;
//    hideLayer.transform = _bottomTransform;
//}

               

@end


//    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    CGFloat startValue = beginsOnTop ? 0.0f : M_PI;
//    CGFloat endValue = beginsOnTop ? -M_PI : 0.0f;
//    flipAnimation.fromValue = [NSNumber numberWithDouble:startValue];
//    flipAnimation.toValue = [NSNumber numberWithDouble:endValue];
//    
//    // Shrinking the view makes it seem to move away from us, for a more natural effect
//    // Can also grow the view to make it move out of the screen
//    CABasicAnimation *shrinkAnimation = nil;
//    if ( scaleFactor != 1.0f ) {
//        shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        shrinkAnimation.toValue = [NSNumber numberWithFloat:scaleFactor];
//        
//        // We only have to animate the shrink in one direction, then use autoreverse to "grow"
//        shrinkAnimation.duration = aDuration * 0.5;
//        shrinkAnimation.autoreverses = YES;
//    }
//    
//    // Combine the flipping and shrinking into one smooth animation
//    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
//    animationGroup.animations = [NSArray arrayWithObjects:flipAnimation, shrinkAnimation, nil];
//    
//    // As the edge gets closer to us, it appears to move faster. Simulate this in 2D with an easing function
//    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animationGroup.duration = aDuration;
//    
//    // Hold the view in the state reached by the animation until we can fix it, or else we get an annoying flicker
//    animationGroup.fillMode = kCAFillModeForwards;
//    animationGroup.removedOnCompletion = NO;
//    
//    return animationGroup;
    
    