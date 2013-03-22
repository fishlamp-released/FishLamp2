//
//  FLSlideInAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLMoveAnimation.h"

@interface FLSlideInAnimation : FLMoveAnimation {
@private
    FLAnimationDirection _slideDirection;
    
    CGPoint _onScreenOrigin;
    CGPoint _offScreenOrigin;
}
+ (id) slideInAnimation:(FLAnimationDirection) slideInDirection;
@end
