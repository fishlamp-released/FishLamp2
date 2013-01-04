//
//  FLViewAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLViewAnimation.h"

@implementation FLViewAnimation

- (id) initWithView:(UIView*) view  {
    self = [self init];
    if(self) {
        [self setView:view];
    }
    return self;
}

+ (id) animationWithView:(UIView*) view {
    return FLAutorelease([[[self class] alloc] initWithView:view]);
}

- (void) prepareAnimationWithView:(UIView*) view {
}

- (void) setView:(UIView*) view {
    FLAssertNotNil_(view);
    FLAssertNotNil_(view.superview);

#if OSX
    view.wantsLayer = YES;
    view.superview.wantsLayer = YES;
#endif          

    [self prepareAnimationWithView:view];
}


@end
