//
//  FLWarningNotificationViewController.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLWarningNotificationViewController.h"

@interface FLWarningNotificationViewController ()

@end

// TODO: stylize "warning" (vs error or info)

@implementation FLWarningNotificationViewController

+ (id<FLPresentationBehavior>) defaultPresentationBehavior {
    return [UIViewController defaultPresentationBehavior];
}

+ (FLPopinViewControllerAnimation*) defaultTransitionAnimation {
    return [FLPopinViewControllerAnimation viewControllerTransitionAnimation];
}


- (id) init {
    self = [super init];
    if(self) {
        
    }
    return self;   
}

+ (FLWarningNotificationViewController*) warningNotificationViewController {
    return FLReturnAutoreleased([[[self class] alloc] init]);   
}

@end

