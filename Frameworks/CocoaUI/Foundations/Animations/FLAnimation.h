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

@protocol FLAnimator <NSObject>
@end

@interface FLAnimation : NSObject<FLDispatchable> {
@private
    FLAnimationPrepareBlock _prepare;
    FLAnimationBlock _commit;
    FLAnimationBlock _finish;
    CGFloat _duration;
    NSString* _timingFunction;
    NSMutableArray* _animations;
}

- (id) initWithView:(UIView*) view;
+ (id) animationWithView:(UIView*) view;

@property (readwrite, copy, nonatomic) FLAnimationPrepareBlock prepare;
@property (readwrite, copy, nonatomic) FLAnimationBlock commit;
@property (readwrite, copy, nonatomic) FLAnimationBlock finish;

- (void) addAnimation:(FLAnimation*) animation;

// these only apply to the animation upon which beginAnimation was called.

@property (readwrite, assign, nonatomic) CGFloat duration;
@property (readwrite, strong, nonatomic) NSString* timingFunction;

- (FLFinisher*) startAnimation;

- (FLFinisher*) startAnimation:(FLCompletionBlock) completion;

- (FLFinisher*) startAnimation:(void (^)()) didStartBlock
                    completion:(FLCompletionBlock) completion;


@end



/*

@implementation MyAnimation

- (void) myMethod {
}

- (id) initWithView:(UIView*) view {
    self = [super initWithView:view];
    if(self) {
    
        // init your object.
    
        self.prepare = ^(id animation){
            // prepare the view here
            
            [animation setCommit:^{
                // set the animatable properties here
                
                // call backinto your object like this (to prevent memory cycle with the blocks)
                [animation myMethod];
            }];
            
            [animation setFinish:^{
                // clean up here.
            }];
        };
    }
        
    return self;
}

@end


*/