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

- (id) init {
    self = [super init];
    if(self) {
        self.fromAlpha = -1;
        self.toAlpha = -1;
    }
    return self;
}

+ (id) fadeAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_DEALLOC
- (void) dealloc {
    
    [super dealloc];
}
#endif

- (void) prepare {
    
    [super prepare];
    
    if(FLFloatEqualToFloat(self.fromAlpha, -1.0f)) {
        self.fromAlpha = [self.targetView alphaValue];
    }
    else {
        [self.targetView setAlphaValue:self.fromAlpha];
    }

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


@end

@interface FLFadeInAnimation ()
@end

@implementation FLFadeInAnimation
- (id) init {
    self = [super init];
    if(self) {
        self.toAlpha = 1.0;
    }
    return self;
}

+ (id) fadeInAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_DEALLOC
- (void) dealloc {
    
    [super dealloc];
}
#endif
@end

@interface FLFadeOutAnimation ()
@end

@implementation FLFadeOutAnimation
- (id) init {
    self = [super init];
    if(self) {
        self.toAlpha = 0.0;
    }
    return self;
}

+ (id) fadeOutAnimation {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_DEALLOC
- (void) dealloc {
    
    [super dealloc];
}
#endif
@end
