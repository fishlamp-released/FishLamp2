//
//  FLBatchAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

@interface FLBatchAnimation : FLAnimation {
@private
    NSMutableArray* _animations;
}

//// use this to add child animations
- (void) addAnimation:(FLAnimation*) animation;

@end