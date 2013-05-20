//
//  GtViewControllerStack.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewControllerStack.h"
#import "GtViewController.h"

#import <objc/runtime.h>

#define GtReturnSingletonStatic(__TYPE)\
        static dispatch_once_t pred; \
        static __TYPE* s_static = nil; \
        dispatch_once(&pred, ^{ s_static = [[[__TYPE class] alloc] init]; }); \
        return s_static 

@interface GtDefaultViewControllerAnimation : NSObject<GtViewControllerStackAnimation> {
}
@end

@implementation GtDefaultViewControllerAnimation

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (GtBlock) finishedBlock
{
    if(finishedBlock)
        finishedBlock();
}    

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (GtBlock) finishedBlock
{
    if(finishedBlock)
        finishedBlock();
}

@end   

@interface GtDropAndSlideInAnimation : NSObject<GtViewControllerStackAnimation>

@end

@implementation GtDropAndSlideInAnimation

- (void) beginShowAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (GtBlock) finishedBlock
{

    CGRect destFrame = viewController.view.superview.bounds;
    viewController.view.frame = GtRectSetLeft(destFrame, GtRectGetRight(destFrame));
    
    CGFloat savedAlpha = parentViewController.view.alpha;
    
    [UIView animateWithDuration:0.3
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
                        finishedBlock();
                    }
                }
            ];
}

- (void) beginHideAnimationForViewController:(UIViewController*) viewController
    parentViewController:(UIViewController*) parentViewController
    finishedBlock: (GtBlock) finishedBlock
{
    CGRect destFrame = GtRectSetLeft(viewController.view.frame, GtRectGetRight(viewController.view.superview.bounds));
    CGFloat savedAlpha = parentViewController.view.alpha;
    parentViewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:0.3
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    parentViewController.view.alpha = savedAlpha;
                    viewController.view.frame = destFrame;
                } 
                completion:^(BOOL completed) {
                    [viewController.view removeFromSuperview];
                    
                    if(finishedBlock)
                    {
                        finishedBlock();
                    }
                }
            ];
}


@end


@implementation GtViewControllerStack

@synthesize viewControllers = m_viewControllers;

+ (id<GtViewControllerStackAnimation>) defaultAnimation
{
    GtReturnSingletonStatic(GtDefaultViewControllerAnimation);
}

+ (id<GtViewControllerStackAnimation>) dropAndSlideFromRightAnimation
{
    GtReturnSingletonStatic(GtDropAndSlideInAnimation);
}

- (id) initWithRootViewController:(UIViewController*) rootViewController
{
    if((self = [super init]))
    {
        m_viewControllers = [[NSMutableArray alloc] init];
    
        [self pushViewController:rootViewController withAnimation:[GtViewControllerStack defaultAnimation]];
    }
    
    return self;
}

+ (GtViewControllerStack*) viewControllerStack:(UIViewController*) rootViewController
{
    return GtReturnAutoreleased([[GtViewControllerStack alloc] initWithRootViewController:rootViewController]);
}

- (void) dealloc
{
    GtRelease(m_viewControllers);
    GtSuperDealloc();
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
   	self.view.layer.shadowColor = [UIColor blackColor].CGColor;
	self.view.layer.shadowOpacity = .8;
	self.view.layer.shadowRadius = 20.0;
	self.view.layer.shadowOffset = CGSizeMake(0,3);
}  

- (UIViewController*) rootViewController
{
    return [m_viewControllers objectAtIndex:0];
}

- (void)pushViewController:(UIViewController *)viewController 
             withAnimation:(id<GtViewControllerStackAnimation>) animation
{
    GtAssertNotNil(viewController);
    GtAssertNotNil(animation);
    UIViewController* parent =  m_viewControllers.count > 0 ? m_viewControllers.lastObject : nil;
        
    [self addChildViewController:viewController];
    viewController.viewControllerStackAnimation = animation;
    viewController.dismissDelegate = self;
    viewController.view.frame = self.view.bounds;

    [self.view addSubview:viewController.view];
    [m_viewControllers addObject:viewController];
    [viewController willBePushedOnViewControllerStack:self];
    
    [animation beginShowAnimationForViewController:viewController 
        parentViewController:parent 
        finishedBlock:^{
            if(parent != self)
            {
                [parent.view removeFromSuperview];
            }
            [viewController wasPushedOnViewControllerStack:self];
            }];
}

- (void) pushViewController:(UIViewController *)viewController
{
    [self pushViewController:viewController withAnimation:[GtViewControllerStack defaultAnimation]];
}

- (UIViewController*) visibleViewController	
{
    return m_viewControllers.lastObject;
}

- (void) visitViewControllers:(GtViewControllerStackVisitor) visitor
{
    if(visitor)
    {
        BOOL stop = NO;
        
        for(UIViewController* viewController in m_viewControllers.reverseObjectEnumerator)
        {
            visitor(viewController, &stop);
            
            if(stop)
            {
                break;
            }
        }
    }
}

- (void) visitViewControllersStartingWithViewController:(UIViewController*) aViewController 
                                                visitor:(GtViewControllerStackVisitor) visitor
{
    if(visitor)
    {
        BOOL foundIt = NO;
        BOOL stop = NO;
        
        for(UIViewController* viewController in m_viewControllers)
        {
            if(viewController == aViewController) 
            {
                foundIt = YES;
            }
        
            if(foundIt)
            {
                visitor(viewController, &stop);
            }
            
            if(stop)
            {
                break;
            }
        }
    }
}                                                

- (void) _removeViewController:(UIViewController*) viewController
{
    for(int i = m_viewControllers.count - 1; i >=0; i--)
    {
        if([m_viewControllers objectAtIndex:i] == viewController)
        {
            viewController.viewControllerStackAnimation = nil;
            viewController.dismissDelegate = nil;
            [viewController removeFromParentViewController];
            [viewController.view removeFromSuperview];
            [m_viewControllers removeObjectAtIndex:i];
            break;
        }
    }
}

- (void) popViewControllerAnimated:(BOOL) animated
{
    if(m_viewControllers.count)
    {
        id<GtViewControllerStackAnimation> animation = animated ? 
            [[m_viewControllers lastObject] viewControllerStackAnimation] :
            [GtViewControllerStack defaultAnimation];
    
        [self popViewControllerWithAnimation:animation]; 
    }
}

- (void) viewControllerDismissDelegate:(UIViewController*) viewController 
         dismissViewControllerAnimated:(BOOL) animated
{
    if(m_viewControllers.count == 1)
    {
        [self dismissViewControllerAnimated:animated];
    }
    else
    {
        [self popViewControllerAnimated:YES];
    }
}

- (void) popViewControllerWithAnimation:(id<GtViewControllerStackAnimation>) animation
{
    GtAssertNotNil(animation);

    UIViewController* visibleController = self.visibleViewController;
    
    UIViewController* parent = [self parentControllerForController:visibleController];
    GtAssertNotNil(parent);

    if(parent != visibleController)
    {
        [visibleController willBePoppedFromViewControllerStack:self];
        parent.view.frame = self.view.bounds;
        [self.view addSubview:parent.view];
        
        [animation beginHideAnimationForViewController:visibleController 
            parentViewController:parent 
            finishedBlock:^{
                    [self _removeViewController:visibleController];
                    [visibleController wasPoppedFromViewControllerStack:self];
                }];
    
    }
}

- (void) popToViewController:(UIViewController*) viewController 
               withAnimation:(id<GtViewControllerStackAnimation>) animation
{
    GtAssertFailedNotImplemented();
}

- (UIViewController*) parentControllerForController:(UIViewController*) aController
{
    UIViewController* last = nil;
    for(UIViewController* viewController in m_viewControllers)
    {
        if(viewController == aController)
        {
            return last;
        }
        
        last = viewController;
    }

    return nil;
}
	
- (BOOL) containsViewController:(UIViewController*) aController
{
    for(UIViewController* viewController in m_viewControllers)
    {
        if(viewController == aController)
        {
            return YES;
        }
    }

    return NO;
}

- (GtViewControllerStack*) viewControllerStack
{
    return self;
}

@end

static void * const kViewControllerStackKey = (void*)&kViewControllerStackKey;
static void * const kViewControllerStackAnimationKey = (void*)&kViewControllerStackAnimationKey;

@implementation UIViewController (GtViewControllerStack)

- (void) willBePushedOnViewControllerStack:(GtViewControllerStack*) controller
{
}

- (void) wasPushedOnViewControllerStack:(GtViewControllerStack*) controller
{
}

- (void) wasPoppedFromViewControllerStack:(GtViewControllerStack*) controller
{
}

- (void) willBePoppedFromViewControllerStack:(GtViewControllerStack*) controller
{
}

- (GtViewControllerStack*) viewControllerStack
{
    return self.parentViewController.viewControllerStack;

//    return objc_getAssociatedObject(self, &kViewControllerStackKey);
}

//- (void) setViewControllerStack:(GtViewControllerStack*) stack
//{
//    objc_setAssociatedObject(self, &kViewControllerStackKey, stack, OBJC_ASSOCIATION_ASSIGN);
//}

- (id<GtViewControllerStackAnimation>) viewControllerStackAnimation
{
    return objc_getAssociatedObject(self, &kViewControllerStackAnimationKey);
}

- (void) setViewControllerStackAnimation:(id<GtViewControllerStackAnimation>) animation
{
    objc_setAssociatedObject(self, &kViewControllerStackAnimationKey, animation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end                                                                              

