//
//  FLSpinningProgressView.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FLRotateAnimation.h"

@interface FLSpinningProgressView : NSView {
@private
    CALayer* _rotationLayer;
    BOOL _animate;
    FLAnimation* _animation;
} 

@property (readonly, assign, nonatomic, getter=isAnimating) BOOL animate;
@property (readwrite, strong, nonatomic) NSImage* image;

- (void) setRespondsToGlobalNetworkActivity:(BOOL) responds;

- (void) startAnimating;
- (void) stopAnimating;

@end
