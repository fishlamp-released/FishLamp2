//
//  FLDropBackAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDropBackAnimation.h"
#define kScaleSmall 0.95f

#define FLShrunkTransform(view)   CATransform3DConcat(CATransform3DMakeTranslation( (view.frame.size.width * (1.0 - kScaleSmall)) / 2.0f,  (view.frame.size.height * (1.0 - kScaleSmall)), 0), CATransform3DMakeScale(kScaleSmall, kScaleSmall, 1))

//CATransform3DConcat(, CATransform3DMakeTranslation(-(view.frame.size.width / 2.0f), -(view.frame.size.height / 2.0f), 0))

@implementation FLZAxisAnimation 


@end

@implementation FLDropBackAnimation

- (void) prepare {
    [super prepare];
    self.targetView.layer.transform = CATransform3DIdentity;
    self.targetView.hidden = NO;
}

- (void) commit {
    [super commit];
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue =   [NSValue valueWithCATransform3D:self.targetView.layer.transform];
    scale.toValue =     [NSValue valueWithCATransform3D:FLShrunkTransform(self.targetView)];
    scale.removedOnCompletion = YES;
    [self.targetView.layer addAnimation:scale forKey:@"transform"];
    self.targetView.layer.transform = FLShrunkTransform(self.targetView);
}


- (void) finish {
    [super finish];
    self.targetView.hidden = YES;
    self.targetView.layer.transform = CATransform3DIdentity;
}

@end


@implementation FLComeForwardAnimation

- (void) prepare {
    [super prepare];
    
    self.targetView.layer.transform = FLShrunkTransform(self.targetView);
    self.targetView.hidden = NO;
}


- (void) commit {
    [super commit];
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue =   [NSValue valueWithCATransform3D:self.targetView.layer.transform];
    scale.toValue =     [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scale.removedOnCompletion = YES;
    [self.targetView.layer addAnimation:scale forKey:@"transform"];
    self.targetView.layer.transform = CATransform3DIdentity;
}

@end
