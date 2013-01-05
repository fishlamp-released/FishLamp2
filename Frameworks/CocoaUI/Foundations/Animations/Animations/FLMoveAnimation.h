//
//  FLMoveAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLAnimation.h"

@interface FLMoveAnimation : FLAnimation {
}

- (void) setTarget:(id) target
        fromOrigin:(CGPoint) fromOrigin 
          toOrigin:(CGPoint) toOrigin;

// for subclasses
- (void) prepareAnimationWithLayer:(CALayer*) layer 
                        fromOrigin:(CGPoint) fromOrigin 
                          toOrigin:(CGPoint) toOrigin;

@end

@interface FLSlideInFromRightAnimation : FLMoveAnimation {
}
@end

@interface FLSlideOutToRightAnimation : FLMoveAnimation {
}
@end