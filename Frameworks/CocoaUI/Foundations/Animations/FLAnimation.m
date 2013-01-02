//
//  FLAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

@interface FLAnimation ()
//@property (readwrite, copy, nonatomic) FLAnimationBlock commit;
//@property (readwrite, copy, nonatomic) FLAnimationBlock finish;
@property (readwrite, strong, nonatomic) NSArray* animations;
@end

@implementation FLAnimation

@synthesize prepare = _prepare;
@synthesize commit = _commit;
@synthesize finish = _finish;
@synthesize duration = _duration;
@synthesize timingFunction = _timingFunction;
@synthesize animations = _animations;


- (id) initWithView:(UIView*) view  {
    self = [self init];
    if(self) {
        FLAssertNotNil_(view);
#if OSX
        view.wantsLayer = YES;
#endif          
    }
    return self;
}

+ (id) animationWithView:(UIView*) view {
    return FLAutorelease([[[self class] alloc] initWithView:view]);
}

- (id) init {
    self = [super init];
    if(self) {
        self.duration = 0.3f;
    }
    return self;
}

+ (id) animation {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_timingFunction release];
    [_prepare release];
    [_commit release];
    [_finish release];
    [_animations release];
    [super dealloc];
}
#endif

- (void) addAnimation:(FLAnimation*) animation {
    if(!_animations) {
        _animations = [[NSMutableArray alloc] init];
    }
    [_animations addObject:animation];
}

- (void) invokePrepare {
    if(_prepare) {
        _prepare(self);
    }
    for(FLAnimation* animation in _animations) {
        [animation invokePrepare];
    }
}

- (void) invokeCommit {
    if(_commit) {
        _commit();
    }
    for(FLAnimation* animation in _animations) {
        [animation invokeCommit];
    }
}

- (void) invokeFinish {
    if(_finish) {
        _finish();
    }
    for(FLAnimation* animation in _animations) {
        [animation invokeFinish];
    }
}

- (void) openAnimation {
    [self invokePrepare];

    [CATransaction begin];
    [CATransaction setAnimationDuration:self.duration];
    
    if(self.timingFunction) {
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:self.timingFunction]];
    }
}

- (void) closeAnimation:(FLFinisher*) finisher {
    [CATransaction setCompletionBlock:^{

        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];
        
        [self invokeFinish];

        [CATransaction commit];
        
        [finisher setFinished];
    }];
    
    [self invokeCommit];
    [CATransaction commit];
    
    self.prepare = nil;
    self.commit = nil;
    self.finish = nil;
    self.animations = nil;
}

- (FLFinisher*) startAnimation:(void (^)()) didStartBlock
                completion:(FLCompletionBlock) completion {

    FLFinisher* finisher = [FLFinisher finisher:completion];
    [self openAnimation];
    if(didStartBlock) {
        didStartBlock();
    }
    [self closeAnimation:finisher];
    return finisher;
}   

- (void) startWorking:(FLFinisher*) finisher {
    [self openAnimation];
    [self closeAnimation:finisher];
}             
                
- (FLFinisher*) startAnimation:(FLCompletionBlock) completion {
    return [self startAnimation:nil completion:completion];
}

- (FLFinisher*) startAnimation {
    return [self startAnimation:nil completion:nil];
}

@end

