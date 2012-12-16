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

#define FLUnshrunkTransform(view) CATransform3DMakeScale(1.0, 1.0, 1)

//CATransform3DConcat(, CATransform3DMakeTranslation(-(view.frame.size.width / 2.0f), -(view.frame.size.height / 2.0f), 0))

@implementation FLDropBackAnimation

- (void) commit {
    [super commit];

    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue =   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)];
    scale.toValue =     [NSValue valueWithCATransform3D:FLShrunkTransform(self.targetView)];
    scale.removedOnCompletion = YES;
    
    self.targetView.layer.transform = FLShrunkTransform(self.targetView);
    [self.targetView.layer addAnimation:scale forKey:@"transform"];
}
@end


@implementation FLComeForwardAnimation

- (void) commit {
    [super commit];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue =   [NSValue valueWithCATransform3D:FLShrunkTransform(self.targetView)];
    scale.toValue =     [NSValue valueWithCATransform3D:FLUnshrunkTransform(self.targetView)];
    scale.removedOnCompletion = YES;
    
    self.targetView.layer.transform = FLShrunkTransform(self.targetView);
    [self.targetView.layer addAnimation:scale forKey:@"transform"];
}
@end
