//
//  FLAnimation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

@implementation FLAnimation

@synthesize prepare = _prepare;
@synthesize commit = _commit;
@synthesize finish = _finish;
@synthesize duration = _duration;
@synthesize timingFunction = _timingFunction;

+ (id) animation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    self = [super init];
    if(self) {
        self.duration = 0.3f;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_timingFunction release];
    [_prepare release];
    [_commit release];
    [_finish release];
    [super dealloc];
}
#endif

- (void) openAnimation {
    if(_prepare) {
        _prepare(self);
    }

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
        
        if(_finish) {
            _finish();
        }

        [CATransaction commit];
        
        [finisher setFinished];
    }];
    
    if(_commit) {
        _commit();
    }
    
    [CATransaction commit];
    
    self.prepare = nil;
    self.commit = nil;
    self.finish = nil;
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

