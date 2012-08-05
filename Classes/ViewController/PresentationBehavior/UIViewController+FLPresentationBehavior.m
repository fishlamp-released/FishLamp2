//
//  UIViewController+FLPresentationBehavior.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/17/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "UIViewController+FLPresentationBehavior.h"

#import <objc/runtime.h>

#import "FLNormalPresentationBehavior.h"

static void * const kPresentationBehaviorKey = (void*)&kPresentationBehaviorKey;

@implementation UIViewController (FLPresentationBehavior)

- (id<FLPresentationBehavior>) presentationBehavior {
    id<FLPresentationBehavior> behavior = objc_getAssociatedObject(self, kPresentationBehaviorKey);
    if(!behavior) {
        behavior = [[self class] defaultPresentationBehavior];
    }
    
    return behavior;
}

- (void) setPresentationBehavior:(id<FLPresentationBehavior>) behavior {
    objc_setAssociatedObject(self, kPresentationBehaviorKey, behavior, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

void (^FLGlobalPresentBlock)(id controller) = ^(id controller) {
    [[UIApplication visibleViewController] presentChildViewController:controller];
};

+ (void (^)(id controller)) defaultPresentModalViewControllerBlock {
    return FLGlobalPresentBlock;
}

+ (id<FLPresentationBehavior>) defaultPresentationBehavior {
    return [FLNormalPresentationBehavior instance];
}

@end
