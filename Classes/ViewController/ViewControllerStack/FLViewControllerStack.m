//
//  FLViewControllerStack.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLViewControllerStack.h"
#import "FLViewController.h"

#import <objc/runtime.h>

@implementation FLViewControllerStack

@synthesize viewControllers = _viewControllers;
@synthesize rootViewController = _rootViewController;

- (id) init {
    if((self = [super init])) {
        _viewControllers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) _addViewController:(UIViewController*) viewController {
    [self addChildViewController:viewController];
    viewController.dismissHandler = ^(UIViewController* controller, BOOL animated) {
        FLViewControllerStack* stack = controller.viewControllerStack;
        if(stack.viewControllers.count == 1) {
            [stack dismissViewControllerAnimated:animated];
        }
        else {
            [stack popViewControllerAnimated:YES];
        }
    };
    
    [_viewControllers addObject:viewController];
}

- (id) initWithRootViewController:(UIViewController*) rootViewController {
    if((self = [super init])) {
        _viewControllers = [[NSMutableArray alloc] init];
        FLAssignObject(_rootViewController, rootViewController);
        [self _addViewController:_rootViewController];
    }
    
    return self;
}

+ (FLViewControllerStack*) viewControllerStack:(UIViewController*) rootViewController {
    return FLReturnAutoreleased([[FLViewControllerStack alloc] initWithRootViewController:rootViewController]);
}

- (void) dealloc {
    FLRelease(_rootViewController);
    FLRelease(_viewControllers);
    FLSuperDealloc();
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    for(UIViewController* controller in _viewControllers) {
        if([controller isViewLoaded]) {
            controller.view.frame = self.view.bounds;
        }
    }
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
   	self.view.layer.shadowColor = [UIColor blackColor].CGColor;
	self.view.layer.shadowOpacity = .8;
	self.view.layer.shadowRadius = 20.0;
	self.view.layer.shadowOffset = CGSizeMake(0,3);
    self.view.clipsToBounds = NO;
    
    _rootViewController.view.frame = self.view.bounds;
   
    [self.view addSubview:_rootViewController.view];
}  

- (void)pushViewController:(UIViewController *)viewController 
             withAnimation:(id<FLViewControllerTransitionAnimation>) animation {
    
    FLAssertIsNotNil(_rootViewController);
    FLAssertIsNotNil(_viewControllers);
    
    if(!animation) {
        animation = [[self class] defaultTransitionAnimation];
    }

    FLAssertIsNotNil(viewController);
    FLAssertIsNotNil(animation);
    
    UIViewController* parent =  _viewControllers.lastObject;
        
    if(viewController.transitionAnimation != animation) {
        viewController.transitionAnimation = animation;
    }
    [self _addViewController:viewController];
    viewController.view.frame = self.view.bounds;
    [self.view addSubview:viewController.view];
    [viewController willBePushedOnViewControllerStack:self];
    [self.view layoutIfNeeded];
    
    [animation beginShowAnimationForViewController:viewController 
        parentViewController:parent 
        finishedBlock:^(id theViewController, id theParent){
            if(theParent != self) {
                [[theParent view] removeFromSuperview];
            }
            [theViewController wasPushedOnViewControllerStack:self];
            }];
}

- (void) pushViewController:(UIViewController *)viewController {
    [self pushViewController:viewController withAnimation:nil];
}

- (UIViewController*) visibleViewController	 {
    return _viewControllers.lastObject;
}

- (void) visitViewControllers:(FLViewControllerStackVisitor) visitor {
    if(visitor) {
        BOOL stop = NO;
        
        for(UIViewController* viewController in _viewControllers.reverseObjectEnumerator) {
            visitor(viewController, &stop);
            
            if(stop) {
                break;
            }
        }
    }
}

- (void) visitViewControllersStartingWithViewController:(UIViewController*) aViewController 
                                                visitor:(FLViewControllerStackVisitor) visitor {
    if(visitor) {
        BOOL foundIt = NO;
        BOOL stop = NO;
        
        for(UIViewController* viewController in _viewControllers) {
            if(viewController == aViewController) {
                foundIt = YES;
            }
        
            if(foundIt) {
                visitor(viewController, &stop);
            }
            
            if(stop) {
                break;
            }
        }
    }
}                                                

- (void) _removeViewController:(UIViewController*) viewController {
    for(int i = _viewControllers.count - 1; i >=0; i--) {
        if([_viewControllers objectAtIndex:i] == viewController) {
            viewController.transitionAnimation = nil;
            viewController.dismissHandler = nil;
            [viewController removeFromParentViewController];
            [viewController.view removeFromSuperview];
            [_viewControllers removeObjectAtIndex:i];
            break;
        }
    }
}

- (void) popViewControllerAnimated:(BOOL) animated
{
    FLAssert(_viewControllers.count, @"no controllers on stack");
    
    if(_viewControllers.count) {
        id<FLViewControllerTransitionAnimation> animation = animated ? 
            [[_viewControllers lastObject] transitionAnimation] :
            [[self class] defaultTransitionAnimation];
    
        [self popViewControllerWithAnimation:animation]; 
    }
}

- (void) popViewControllerWithAnimation:(id<FLViewControllerTransitionAnimation>) animation {
    FLAssertIsNotNil(animation);

    UIViewController* visibleController = self.visibleViewController;
    
    UIViewController* parent = [self parentControllerForController:visibleController];
    FLAssertIsNotNil(parent);

    if(parent != visibleController) {
        [visibleController willBePoppedFromViewControllerStack:self];
        parent.view.frame = self.view.bounds;
        [self.view insertSubview:parent.view belowSubview:visibleController.view];
        [self.view layoutIfNeeded];

        [animation beginHideAnimationForViewController:visibleController 
            parentViewController:parent 
            finishedBlock:^(id theViewController, id theParent){
                    [self _removeViewController:theViewController];
                    [theViewController wasPoppedFromViewControllerStack:self];
                }];
    
    }
}

- (void) popToViewController:(UIViewController*) viewController 
               withAnimation:(id<FLViewControllerTransitionAnimation>) animation {
    FLNotImplemented(@"pop to view controller");
}

- (UIViewController*) parentControllerForController:(UIViewController*) aController {
    UIViewController* last = nil;
    for(UIViewController* viewController in _viewControllers) {
        if(viewController == aController) {
            return last;
        }
        
        last = viewController;
    }

    return nil;
}
	
- (BOOL) containsViewController:(UIViewController*) aController {
    for(UIViewController* viewController in _viewControllers) {
        if(viewController == aController) {
            return YES;
        }
    }

    return NO;
}

- (FLViewControllerStack*) viewControllerStack {
    return self;
}

@end

@implementation UIViewController (FLViewControllerStack)

- (void) willBePushedOnViewControllerStack:(FLViewControllerStack*) controller {
}

- (void) wasPushedOnViewControllerStack:(FLViewControllerStack*) controller {
}

- (void) wasPoppedFromViewControllerStack:(FLViewControllerStack*) controller {
}

- (void) willBePoppedFromViewControllerStack:(FLViewControllerStack*) controller {
}

- (FLViewControllerStack*) viewControllerStack {
    return self.parentViewController.viewControllerStack;
}

@end                                                                              

