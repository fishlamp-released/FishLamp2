//
//  FLViewControllerTransitionAnimation.h
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/12/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

// transition animations

typedef void (^FLViewControllerBlock)(id viewController);
typedef void (^FLViewControllerAnimationBlock)(id viewController, id parentViewController);

@protocol FLViewControllerTransitionAnimation <NSObject> 

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
                        parentViewController:(UIViewController*) parentViewController
                               finishedBlock:(FLViewControllerAnimationBlock) finishedBlock; 

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
                        parentViewController:(UIViewController*) parentViewController
                               finishedBlock:(FLViewControllerAnimationBlock) finishedBlock; 

@end  

@interface FLViewControllerTransitionAnimation : NSObject<FLViewControllerTransitionAnimation> {
@private
    FLViewControllerAnimationBlock _callback;
}

@property (readwrite, copy, nonatomic) FLViewControllerAnimationBlock callback;

+ (id) viewControllerTransitionAnimation;

@end

@interface FLDefaultViewControllerAnimation : FLViewControllerTransitionAnimation 
@end

@interface FLDropAndSlideInFromRightAnimation : FLViewControllerTransitionAnimation
@end

@interface FLDropAndSlideInFromLeftAnimation : FLViewControllerTransitionAnimation
@end

@interface FLCrossFadeAnimation : FLViewControllerTransitionAnimation
@end

@interface FLPopinViewControllerAnimation : FLViewControllerTransitionAnimation {
@private
    UIViewController* _parent;
    UIViewController* _viewController;
}
@end
