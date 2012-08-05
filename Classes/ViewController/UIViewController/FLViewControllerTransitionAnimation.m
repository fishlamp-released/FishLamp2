//
//  FLViewControllerTransitionAnimation.m
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/12/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLViewControllerTransitionAnimation.h"
#import "UIViewController+FLExtras.h"

@implementation FLViewControllerTransitionAnimation

@synthesize callback = _callback;

+ (id) viewControllerTransitionAnimation
{
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
    if(finishedBlock)
        finishedBlock(viewController, parentViewController);
}    

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
    if(finishedBlock)
        finishedBlock(viewController, parentViewController);
}

#if OBJC_ARC
- (void) dealloc
{
    [_callback release];
    [super dealloc];
}
#endif

@end

@implementation FLDefaultViewControllerAnimation

FLSynthesizeSingleton(FLDefaultViewControllerAnimation);

+ (id) viewControllerTransitionAnimation
{
    return [self instance];
}

@end   

@implementation FLDropAndSlideInFromRightAnimation

FLSynthesizeSingleton(FLDropAndSlideInFromRightAnimation);

+ (id) viewControllerTransitionAnimation
{
    return [self instance];
}

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{

    CGRect destFrame = viewController.view.superview.bounds;
    viewController.view.frame = FLRectSetLeft(destFrame, FLRectGetRight(destFrame));
    
    CGFloat savedAlpha = parentViewController.view.alpha;
    
    [UIView animateWithDuration:0.4
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
      //              parentViewController.view.frame = CGRectInset(parentViewController.view.frame, 10, 10);
                    parentViewController.view.alpha = 0.0;
                    viewController.view.frame = destFrame;
                } 
                completion:^(BOOL completed) {
                    parentViewController.view.alpha = savedAlpha;
      //              parentViewController.view.frame = CGRectInset(parentViewController.view.frame, -10, -10);
                    if(finishedBlock)
                    {
                        finishedBlock(viewController, parentViewController);
                    }
                }
            ];
}

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
    CGRect destFrame = FLRectSetLeft(viewController.view.frame, FLRectGetRight(viewController.view.superview.bounds));
    CGFloat savedAlpha = parentViewController.view.alpha;
    parentViewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:0.4
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    parentViewController.view.alpha = savedAlpha;
                    viewController.view.frame = destFrame;
                } 
                completion:^(BOOL completed) {
                    if(finishedBlock)
                    {
                        finishedBlock(viewController, parentViewController);
                    }
                }
            ];
}


@end

@implementation FLDropAndSlideInFromLeftAnimation

FLSynthesizeSingleton(FLDropAndSlideInFromLeftAnimation);

+ (id) viewControllerTransitionAnimation
{
    return [self instance];
}

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
                        parentViewController:(UIViewController*) parentViewController
                               finishedBlock:(FLViewControllerAnimationBlock) finishedBlock
{

    CGRect destFrame = viewController.view.superview.bounds;
    viewController.view.frame = FLRectSetLeft(destFrame, -destFrame.size.width);
    
    CGFloat savedAlpha = parentViewController.view.alpha;
    
    [UIView animateWithDuration:0.4
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    parentViewController.view.alpha = 0.0;
                    viewController.view.frame = destFrame;
                } 
                completion:^(BOOL completed) {
                    parentViewController.view.alpha = savedAlpha;
                    if(finishedBlock)
                    {
                        finishedBlock(viewController, parentViewController);
                    }
                }
            ];
}

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
                        parentViewController:(UIViewController*) parentViewController
                               finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
    CGRect destFrame = viewController.view.frame;
    destFrame.origin.x = -destFrame.size.width;

    CGFloat savedAlpha = parentViewController.view.alpha;
    parentViewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:0.4
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    parentViewController.view.alpha = savedAlpha;
                    viewController.view.frame = destFrame;
                } 
                completion:^(BOOL completed) {
                    if(finishedBlock)
                    {
                        finishedBlock(viewController, parentViewController);
                    }
                }
            ];
}


@end


@implementation FLCrossFadeAnimation

FLSynthesizeSingleton(FLCrossFadeAnimation);

+ (id) viewControllerTransitionAnimation
{
    return [self instance];
}

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
    CGFloat savedParentAlpha = parentViewController.view.alpha;
    CGFloat savedNewAlpha = viewController.view.alpha;
    viewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:0.25
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    parentViewController.view.alpha = 0.0;
                    viewController.view.alpha = savedNewAlpha;
                } 
                completion:^(BOOL completed) {
                    parentViewController.view.alpha = savedParentAlpha;
                    if(finishedBlock)
                    {
                        finishedBlock(viewController, parentViewController);
                    }
                }
            ];
}

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
    CGFloat savedParentAlpha = parentViewController.view.alpha;
    CGFloat savedNewAlpha = viewController.view.alpha;
    parentViewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:0.25
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    viewController.view.alpha = 0.0;
                    parentViewController.view.alpha = savedParentAlpha;
                } 
                completion:^(BOOL completed) {
                    viewController.view.alpha = savedNewAlpha;
                    if(finishedBlock)
                    {
                        finishedBlock(viewController, parentViewController);
                    }
                }
            ];
}
@end

@implementation FLPopinViewControllerAnimation


- (void)animationDidStart:(CAAnimation *)anim
{
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.callback)
    {
        self.callback(_viewController, _parent);
    }
    FLReleaseWithNil(_viewController);
    FLReleaseWithNil(_parent);
}

- (void) dealloc
{
    FLReleaseWithNil(_viewController);
    FLReleaseWithNil(_parent);

    FLSuperDealloc();
}

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
    self.callback = finishedBlock;

    FLAssignObject(_viewController, viewController);
    FLAssignObject(_parent, parentViewController);

	CALayer *viewLayer = viewController.view.layer;
	CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
	
	popInAnimation.duration = 0.25f;
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
	popInAnimation.delegate = self;
	
	[viewLayer addAnimation:popInAnimation forKey:@"transform.scale"];	
}

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (FLViewControllerAnimationBlock) finishedBlock
{
    self.callback = finishedBlock;
    FLAssignObject(_viewController, viewController);
    FLAssignObject(_parent, parentViewController);

	CALayer *viewLayer = viewController.view.layer;
	CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
	
	popInAnimation.duration = 0.15f;
	popInAnimation.values = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:1.0],
                                [NSNumber numberWithFloat:0.0],
                                nil];
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
							   [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:1.0], 
							   nil];	
	popInAnimation.delegate = self;
	
	[viewLayer addAnimation:popInAnimation forKey:@"transform.scale"];	
}

    
@end