//
//  FLWarningNotificationAlert.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLWarningNotificationAlert.h"

@interface FLWarningNotificationAlert ()

@end

// TODO: stylize "warning" (vs error or info)

@implementation FLWarningNotificationAlert

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

+ (FLWarningNotificationAlert*) warningNotificationAlert {
    return FLAutorelease([[[self class] alloc] init]);   
}

@end

