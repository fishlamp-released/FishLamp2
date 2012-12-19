//
//  FLFadeAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFadeAnimation.h"

@interface FLFadeAnimation ()
@property (readwrite, assign, nonatomic) CGFloat fromAlpha;
@end

@implementation FLFadeAnimation

@synthesize fromAlpha = _fromAlpha;
@synthesize toAlpha = _toAlpha;

- (id) initWithTarget:(id) target {
    self = [super initWithTarget:target];
    if(self) {
        self.toAlpha = 0.0f;
    }
    return self;
}

+ (id) fadeAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}


    
- (void) prepare { 
    [super prepare];

    self.targetView.alphaValue = self.fromAlpha;
    self.targetView.hidden = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"alphaValue"];
    animation.fromValue = [NSNumber numberWithFloat:self.fromAlpha];
    animation.toValue = [NSNumber numberWithFloat:self.toAlpha];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeBoth;
    animation.additive = NO;
    [self.targetView setAnimations:[NSDictionary dictionaryWithObjectsAndKeys:animation, @"alphaValue", nil]];
}

- (void) commit {
    
    [super commit];
    
#if OSX
    [[self.targetView  animator] setAlphaValue:self.toAlpha];
#else
    [self.targetView setAlpha:self.toAlpha];
#endif
}

- (void) restore {
    [self.targetView setAlphaValue:self.fromAlpha];
}

@end

@interface FLFadeInAnimation ()
@end

@implementation FLFadeInAnimation

- (id) initWithTarget:(id) target options:(FLAnimationOptions) options {
    self = [super initWithTarget:target options:options];
    if(self) {
        self.fromAlpha = 0.0;
        self.toAlpha = 1.0f;
    }
    return self;
}


@end

@implementation FLFadeOutAnimation

- (id) initWithTarget:(id) target options:(FLAnimationOptions) options {
    self = [super initWithTarget:target options:options];
    if(self) {
        self.toAlpha = 0.0f;
        self.fromAlpha = 1.0f;
    }
    return self;
}

- (void) finish {
    [super finish];
    self.targetView.hidden = YES;
    [self restore];
}

@end
