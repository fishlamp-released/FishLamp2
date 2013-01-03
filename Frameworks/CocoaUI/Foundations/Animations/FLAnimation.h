//
//  FLAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

@class FLAnimation;

typedef void (^FLAnimationPrepareBlock)(id animation);
typedef void (^FLAnimationBlock)();

@interface FLAnimation : NSObject<FLDispatchable> {
@private
    FLAnimationPrepareBlock _prepare;
    FLAnimationBlock _commit;
    FLAnimationBlock _finish;
    CGFloat _duration;
    NSString* _timingFunction;
}

@property (readwrite, copy, nonatomic) FLAnimationPrepareBlock prepare;
@property (readwrite, copy, nonatomic) FLAnimationBlock commit;
@property (readwrite, copy, nonatomic) FLAnimationBlock finish;

// these only apply to the animation upon which beginAnimation was called.
@property (readwrite, assign, nonatomic) CGFloat duration;
@property (readwrite, strong, nonatomic) NSString* timingFunction;

+ (id) animation;

- (FLFinisher*) startAnimation;

- (FLFinisher*) startAnimation:(FLCompletionBlock) completion;

- (FLFinisher*) startAnimation:(void (^)()) didStartBlock
                    completion:(FLCompletionBlock) completion;

@end


