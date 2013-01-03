//
//  FLDropBackAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDropBackAnimation.h"
#define kScaleSmall 0.95f

#define FLShrunkTransform(view)   

CATransform3D FLMakeShrinkAwayTransform(UIView* view, CGFloat scaleAmount) {

    CGRect frame = view.frame;

    CATransform3D scaleTransform = CATransform3DMakeScale(scaleAmount, scaleAmount, 1);
    CATransform3D translateTransform = CATransform3DMakeTranslation((frame.size.width * (1.0 - scaleAmount)) / 2.0f,  
                                                                    (frame.size.height * (1.0 - scaleAmount)), 0);

    return CATransform3DConcat(translateTransform, scaleTransform);

} 

@implementation FLDropBackAnimation

- (void) prepareViewAnimation:(UIView*) view {    
    self.prepare = ^(id animation) {
        view.layer.transform = CATransform3DIdentity;
        view.hidden = NO;

        CATransform3D transform = FLMakeShrinkAwayTransform(view,kScaleSmall);
        
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
        scale.fromValue =   [NSValue valueWithCATransform3D:view.layer.transform];
        scale.toValue =     [NSValue valueWithCATransform3D:transform];
        scale.removedOnCompletion = YES;

        self.commit = ^{
            [view.layer addAnimation:scale forKey:@"transform"];
            view.layer.transform =  transform;
        };

        self.finish = ^{
            view.hidden = YES;
            view.layer.transform = CATransform3DIdentity;
        };
    };
}

@end

