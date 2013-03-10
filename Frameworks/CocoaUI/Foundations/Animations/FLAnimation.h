//
//  FLAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"


@class FLAnimation;

//typedef void (^FLAnimationBlock)(CALayer* layer);

//@interface FLAnimator : NSObject
//@property (readwrite, copy, nonatomic) FLAnimationBlock prepare;
//@property (readwrite, copy, nonatomic) FLAnimationBlock commit;
//@property (readwrite, copy, nonatomic) FLAnimationBlock finish;
//@end

@interface FLAnimation : NSObject

// these only apply to the animation upon which beginAnimation was called.
@property (readwrite, assign, nonatomic) CGFloat duration;
@property (readwrite, strong, nonatomic) NSString* timingFunction;

+ (id) animation;

// to animated call one of these
- (void) startAnimating:(id) target;

- (void) startAnimating:(id) target
             completion:(void (^)()) completion;

- (void) startAnimating:(id) target
          didStartBlock:(void (^)()) didStartBlock
             completion:(void (^)()) completion;

// use this to add child animations
- (void) addAnimation:(FLAnimation*) animation;

- (void) prepareLayer:(CALayer*) layer;
- (void) commitAnimation:(CALayer*) layer;
- (void) finishAnimation:(CALayer*) layer;

@end


