//
//  FLOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/29/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOperation.h"
#import "FishLampAsync.h"
#import "FLBroadcaster.h"

@interface FLOperation ()
@property (readwrite, assign, getter=wasCancelled) BOOL cancelled;
@property (readwrite, strong) FLFinisher* finisher; 
@property (readwrite, assign) id<FLAsyncQueue> asyncQueue;
@end

@implementation FLOperation

@synthesize asyncQueue = _asyncQueue;
@synthesize identifier = _identifier;
@synthesize storageService = _storageService;
@synthesize cancelled = _cancelled;
@synthesize finisher = _finisher;

- (id) init {
    self = [super init];
    if(self) {
  		static int32_t s_counter = 0;
        self.identifier = [NSNumber numberWithInt:FLAtomicIncrement32(s_counter)];
        self.finisher = [FLFinisher finisher];
        self.finisher.delegate = self;
    }
    return self;
}

- (void) dealloc {
    _finisher.delegate = nil;
    
#if FL_MRC
    [_identifier release];
    [_storageService release];
	[_finisher release];
	[super dealloc];
#endif
}

- (FLFinisher*) willStartInQueue:(id<FLAsyncQueue>) asyncQueue {
    return self.finisher;
}

- (void) startInQueue:(id<FLAsyncQueue>) queue {
    self.asyncQueue = self.asyncQueue;
    [self startOperation];
    [self.observers notify:@selector(operationWillBegin:) withObject:self];
}

- (id<FLPromisedResult>) runSynchronouslyInQueue:(id<FLAsyncQueue>) asyncQueue {
    FLPromise* promise = [self.finisher addPromise];
    [self startInQueue:asyncQueue];
    return [promise waitUntilFinished];
}

- (void) startOperation {
    FLLog(@"%@ operation did nothing, you must override startOperation.", NSStringFromClass([self class]));
    [self.finisher setFinished];
}

- (void) requestCancel {
    self.cancelled = YES;
    NSArray* children = nil;

    @synchronized(self) {
        children = FLCopyWithAutorelease(_children);
    }

    for(FLOperation* operation in children) {
        [operation requestCancel];
    }
}

- (FLAsyncEvent*) asyncEventForQueue:(id<FLAsyncQueue>) queue withDelay:(NSTimeInterval) delay {
    return [FLOperationEvent operationEventWithDelay:delay operation:self];
}

- (void) willRunChildOperation:(FLOperation*) operation {

    @synchronized(self) {
        if(!_children) {
            _children = [[NSMutableArray alloc] init];
        }

        [_children addObject:operation];
        [operation.observers addObserver:self];
    }

}

- (void) didRunChildOperation:(FLOperation*) operation {
    @synchronized(self) {
        [operation.observers removeObserver:self];
        [_children removeObject:operation];
    }
}

- (FLPromisedResult) runChildSynchronously:(FLOperation*) operation {

    FLAssertNotNilWithComment(operation, @"child operation is nil");

    [self willRunChildOperation:operation];
    
    FLPromisedResult result = nil;
    @try {
        result = [self.asyncQueue runSynchronously:operation];
    }
    @catch(NSException* ex) {
        result = ex.error;
    }

    FLAssertNotNilWithComment(result, @"result should not be nil");
    
    [self didRunChildOperation:operation];
        
    return result;
}

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation 
                           completion:(fl_completion_block_t) completionOrNil {

    [self willRunChildOperation:operation];

    FLPrepareBlockForFutureUse(completionOrNil);

    return [self.asyncQueue queueObject:operation
                             completion:^(FLPromisedResult result) {

        [self didRunChildOperation:operation];
        
        if(completionOrNil) {
            completionOrNil(result);
        }
    }];
}

- (FLPromise*) runChildAsynchronously:(FLOperation*) operation {
    return [self runChildAsynchronously:operation completion:nil];
}

- (void) abortIfCancelled {
    if(self.wasCancelled) {
        FLThrowError([NSError cancelError]);
    }
}

- (void) finisherDidFinish:(FLFinisher*) finisher
                withResult:(FLPromisedResult) result {
            
    [self didFinishWithResult:result];
    [self.observers notify:@selector(operationDidFinish:withResult:) withObject:self withObject:result];
    self.asyncQueue = nil;
    self.cancelled = NO;
}

- (void) didFinishWithResult:(FLPromisedResult) result {
}

- (void) setFinished {
    [self setFinishedWithResult:[FLSuccessfulResult successfulResult]];
}

- (void) setFinishedWithResult:(id) result {
    [self.finisher setFinishedWithResult:result];
}

@end

