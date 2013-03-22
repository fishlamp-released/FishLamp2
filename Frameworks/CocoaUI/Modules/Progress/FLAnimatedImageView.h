//
//  FLAnimatedImageView.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FLRotateAnimation.h"

@interface FLAnimatedImageView : NSView {
@private
    CALayer* _rotationLayer;
    BOOL _animating;
    FLLayerAnimation* _animation;
    BOOL _displayedWhenStopped;
} 

@property (readwrite, assign, nonatomic) FLLayerAnimation* animation; // FLSomersaultAnimation by default
@property (readwrite, assign, nonatomic, getter=isDisplayedWhenStopped) BOOL displayedWhenStopped;
@property (readonly, assign, nonatomic, getter=isAnimating) BOOL animating;

- (void) startAnimating;
- (void) stopAnimating;

@property (readwrite, strong, nonatomic) NSImage* image;
- (void) setImageWithNameInBundle:(NSString*) name;

// random!
- (void) setRespondsToGlobalNetworkActivity:(BOOL) responds;

@end
