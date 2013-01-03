//
//  FLMoveAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLViewAnimation.h"

@interface FLMoveAnimation : FLViewAnimation {
}
- (void) prepareToMoveView:(UIView*) view 
                fromOrigin:(CGPoint) fromOrigin 
                  toOrigin:(CGPoint) toOrigin;

@end

@interface FLSlideInFromRightAnimation : FLMoveAnimation {
}
@end

@interface FLSlideOutToRightAnimation : FLMoveAnimation {
}
@end