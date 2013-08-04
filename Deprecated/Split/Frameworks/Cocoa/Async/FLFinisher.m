//
//  FLFinisher.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFinisher.h"
#import "FishLampAsync.h"

@interface FLPromise ()
- (void) setFinishedWithResult:(FLPromisedResult) result;
@property (readwrite, strong) FLPromise* nextPromise;
@end

@interface FLFinisher ()
@property (readwrite, strong) FLPromise* firstPromise;
@end

@implementation FLFinisher 
@synthesize firstPromise = _firstPromise;
@synthesize delegate = _delegate;

- (id) init {	
    return [self initWithPromise:nil];
}

- (id) initWithPromise:(FLPromise*) promise {	
	self = [super init];
	if(self) {
        self.firstPromise = promise;
	}
	return self;
}

+ (id) finisher {
    return FLAutorelease([[[self class] alloc] initWithPromise:nil]);
}

+ (id) finisherWithBlock:(fl_completion_block_t) completion {
    return [self finisherWithPromise:[FLPromise promise:completion]];
}

+ (id) finisherWithTarget:(id) target action:(SEL) action {
    return [self finisherWithPromise:[FLPromise promise:target action:action]];
}

+ (id) finisherWithPromise:(FLPromise*) promise {
    return FLAutorelease([[[self class] alloc] initWithPromise:promise]);
}

- (void) addPromise:(FLPromise*) promise {
    promise.nextPromise = self.firstPromise;
    self.firstPromise = promise;
}

- (FLPromise*) addPromise {
    FLPromise* promise = [FLPromise promise];
    [self addPromise:promise];
    return promise;
}

- (FLPromise*) addPromiseWithBlock:(fl_completion_block_t) completion {
    FLPromise* promise = [FLPromise promise:completion];
    [self addPromise:promise];
    return promise;
}

- (FLPromise*) addPromiseWithTarget:(id) target action:(SEL) action {
    FLPromise* promise = [FLPromise promise:target action:action];
    [self addPromise:promise];
    return promise;
}


#if FL_MRC
- (void) dealloc {
    [_firstPromise release];
	[super dealloc];
}
#endif

- (BOOL) willFinish {
    return self.firstPromise != nil;
}

- (void) setFinishedWithResult:(FLPromisedResult) result {

    if(!result) {
        result = [NSError failedResultError];
    }

    [self.delegate finisherDidFinish:self withResult:result];

    FLPromise* promise = FLRetainWithAutorelease(self.firstPromise);
    self.firstPromise = nil;
    while(promise) {
        [promise setFinishedWithResult:result];
        promise = promise.nextPromise;
    }
}      


- (void) setFinished {
    [self setFinishedWithResult:[FLSuccessfulResult successfulResult]];
}

- (void) setFinishedWithCancel {
    [self setFinishedWithResult:[NSError cancelError]];
}


@end
