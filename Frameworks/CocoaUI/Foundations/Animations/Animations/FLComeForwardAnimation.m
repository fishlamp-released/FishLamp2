//
//  FLComeForwardAnimation.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLComeForwardAnimation.h"
#import "FLDropBackAnimation.h"

@implementation FLComeForwardAnimation

- (id) initWithView:(UIView*) view {
    self = [super initWithView:view];
    if(self) {
    
        self.prepare = ^(id animation) {

            view.layer.transform = FLMakeShrinkAwayTransform(view,kScaleSmall);
            view.hidden = NO;
            
            CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
            scale.fromValue =   [NSValue valueWithCATransform3D:view.layer.transform];
            scale.toValue =     [NSValue valueWithCATransform3D:CATransform3DIdentity];
            scale.removedOnCompletion = YES;
            
            self.commit = ^{
                [view.layer addAnimation:scale forKey:@"transform"];
                view.layer.transform =  CATransform3DIdentity;
            };
        };
    }
    return self;
}


@end
