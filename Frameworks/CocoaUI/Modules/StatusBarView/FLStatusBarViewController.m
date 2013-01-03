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

@implementation FLStatusBarViewController

- (id) init {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
    }
    
    return self;
}

- (void)loadView {
    FLView* rootView = [[FLView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    [self setView:rootView];
}


//- (void) flipToNextNotificationViewWithDirection:(FLFlipViewAnimatorDirection) direction 
//                                        nextView:(UIView*) nextView
//                                      completion:(void (^)()) completion {
//
//    completion = FLCopyWithAutorelease(completion);
//
//    FLFlipTransition* animation = [FLFlipTransition transitionWithViewToShow:nextView 
//                                                       viewToHide:self.notificationView];
//                                              
//    [animation startAnimation:^(FLResult result) {
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
//            [self flipToNextNotificationViewWithDirection:FLFlipViewAnimatorDirectionDown nextView:notificationView completion:completion];
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
