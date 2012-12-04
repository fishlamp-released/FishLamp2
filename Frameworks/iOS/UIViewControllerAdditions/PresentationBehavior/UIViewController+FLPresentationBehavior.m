//
//  UIViewController+FLPresentationBehavior.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/17/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "UIViewController+FLPresentationBehavior.h"

#import "FLNormalPresentationBehavior.h"

@implementation UIViewController (FLPresentationBehavior)

FLSynthesizeAssociatedProperty(retain_nonatomic, _presentationBehavior, setPresentationBehavior, id<FLPresentationBehavior>);

- (id<FLPresentationBehavior>) presentationBehavior {
    id<FLPresentationBehavior> behavior = [self _presentationBehavior];
    if(!behavior) {
        behavior = [[self class] defaultPresentationBehavior];
    }
    
    return behavior;
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
