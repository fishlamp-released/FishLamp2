//
//  FLViewAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

@interface FLViewAnimation : FLAnimation

- (id) initWithView:(UIView*) view;
+ (id) animationWithView:(UIView*) view;
- (void) setView:(UIView*) view;

// override this
- (void) prepareViewAnimation:(UIView*) view;
@end
