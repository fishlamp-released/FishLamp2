//
//  FLFadeAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFadeAnimation.h"

@implementation FLFadeAnimation

+ (id) fadeAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) prepareToFadeView:(UIView*) view fromAlpha:(CGFloat) fromAlpha toAlpha:(CGFloat) toAlpha {
    
    view.alphaValue = fromAlpha;
    view.hidden = NO;
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"alphaValue"];
    fade.fromValue = [NSNumber numberWithFloat:fromAlpha];
    fade.toValue = [NSNumber numberWithFloat:toAlpha];
    fade.removedOnCompletion = YES;
    fade.fillMode = kCAFillModeBoth;
    fade.additive = NO;
    [view setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:fade, @"alphaValue", nil]];
    
    self.commit = ^{
#if OSX
        [[view  animator] setAlphaValue:toAlpha];
#else
        [view setAlpha:toAlpha];
#endif
    };
}

@end

@implementation FLFadeInAnimation

- (void) prepareViewAnimation:(UIView*) view {
    self.prepare = ^(id animation) {
        [animation prepareToFadeView:view fromAlpha:0.0 toAlpha:1.0];
    };
}

@end

@implementation FLFadeOutAnimation

- (void) prepareViewAnimation:(UIView*) view {
    self.prepare = ^(id animation) {
        [animation prepareToFadeView:view fromAlpha:1.0 toAlpha:0.0];
    
        self.finish = ^{
            view.hidden = YES;
            [view setAlphaValue:1.0];
        };
    };
}

@end
