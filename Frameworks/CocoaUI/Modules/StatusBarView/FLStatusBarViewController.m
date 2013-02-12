//
//  FLStatusBarViewController.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStatusBarViewController.h"
#import "FLStatusBarView.h"
#import "FLView.h"
#import "FLFlipTransition.h"
#import "FLPopInAnimation.h"
#import "FLFadeAnimation.h"

@implementation FLStatusBarViewController

- (id) init {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        _stack = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_stack release];
    [super dealloc];
}
#endif


- (void)loadView {
    FLView* rootView = FLAutorelease([[FLView alloc] initWithFrame:CGRectMake(0,0,100,100)]);
    rootView.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
    
    rootView.wantsLayer = YES;
    rootView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    [self setView:rootView];
}


- (void) addStatusView:(UIView*) view 
               animated:(BOOL) animated
               completion:(void (^)()) completion {


    UIView* rootView = self.view;
    view.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
    view.frame = rootView.bounds;
    [rootView addSubview:view];

    if(animated) {
        FLSafeguardBlock(completion);

        UIView* lastView = [_stack lastObject];
        if(lastView) {
            FLFlipTransition* fuckyoupieceofshit = [FLFlipTransition transitionWithViewToShow:view viewToHide:lastView flipDirection:FLFlipAnimationDirectionUp];
            [fuckyoupieceofshit startAnimating:completion];
        }
        else {
            [[FLPopInAnimation animationWithTarget:view] startAnimating:completion];
        }
    }   
    else {
        if(completion) {
            completion();
        }

    }
}               

- (void) setStatusView:(UIView*) view 
              animated:(BOOL) animated 
              completion:(void (^)()) completion {

    FLSafeguardBlock(completion);

    __unsafe_unretained id SELF = self;
    [SELF addStatusView:view animated:animated completion:^{
        [self removeAllStatusViewsAnimated:NO completion:nil];

        [_stack addObject:view];
        
        if(completion) {
            completion();
        }
    }];
}              

- (void) pushStatusView:(UIView*) view 
               animated:(BOOL) animated 
               completion:(void (^)()) completion{

    FLSafeguardBlock(completion);

    __unsafe_unretained id SELF = self;
    [SELF addStatusView:view animated:animated completion:^{
        [_stack addObject:view];

        if(completion) {
            completion();
        }
    }];
}               
               
- (void) popStatusViewAnimated:(BOOL) animated completion:(void (^)()) completion {

    UIView* toHide = [_stack dequeueLastObject];
            
    if(animated) {
        if(_stack.count >= 2) {
            UIView* toShow = [_stack lastObject];
            [[FLFlipTransition transitionWithViewToShow:toShow viewToHide:toHide flipDirection:FLFlipAnimationDirectionDown] startAnimating:completion];
        }
        else {
        
            FLSafeguardBlock(completion);
        
            [[FLFadeOutAnimation animationWithTarget:toHide] startAnimating:^(FLResult result) {
                [toHide removeFromSuperview];

                if(completion) {
                    completion();
                }
            }];
        }
    }
    else {
        [toHide removeFromSuperview];
        
        if(completion) {
            completion();
        }
    }
}

- (void) removeAllStatusViewsAnimated:(BOOL) animated completion:(void (^)()) completion{
    for(UIView* view in _stack) {
        [view removeFromSuperview];
    }
    [_stack removeAllObjects];
    
    if(completion) {
        completion();
    }
}


//- (void) flipToNextNotificationViewWithDirection:(FLFlipAnimationDirection) direction 
//                                        nextView:(UIView*) nextView
//                                      completion:(void (^)()) completion {
//
//    completion = FLCopyWithAutorelease(completion);
//
//    FLFlipTransition* animation = [FLFlipTransition transitionWithViewToShow:nextView 
//                                                       viewToHide:self.notificationView];
//                                              
//    [animation startAnimating:^(FLResult result) {
//        [self.notificationView removeFromSuperview];
//        self.notificationView = nextView;
//        if(completion) {
//            completion();
//        }
//    }];
//}
//
//- (void) setNotificationView:(UIView*) notificationView 
//                    animated:(BOOL) animated 
//                  completion:(void (^)()) completion {
//    
//    notificationView.frame = self.notificationViewEnclosure.bounds;
//    if(self.notificationView) {
//        if(animated) {
//            [self flipToNextNotificationViewWithDirection:FLFlipAnimationDirectionDown nextView:notificationView completion:completion];
//        }
//        else {
//            [self.notificationView removeFromSuperview];
//            self.notificationView = notificationView;
//            [self.notificationViewEnclosure addSubview:notificationView];
//            
//            if(completion) completion();
//        }
//    }
//    else {
//        self.notificationView = notificationView;
//        [self.notificationViewEnclosure addSubview:notificationView];
//        if(completion) completion();
//    }
//}
//
//- (void) hideNotificationViewAnimated:(BOOL) animated 
//                  completion:(void (^)()) completion {
//
//    [self.notificationView removeFromSuperview];
//    self.notificationView = nil;
//    if(completion) completion();
//
//}                  


@end
