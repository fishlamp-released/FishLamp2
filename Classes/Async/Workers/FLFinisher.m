//
//  FLFinisher.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFinisher.h"
#import "FLDispatchQueues.h"

//NS_INLINE 
//FLRunner* FLRunWorker(id<FLWorker>)

//@protocol FLAsyncMessage <NSObject>
//- (BOOL) objectWillHandleAsyncMessage:(id) object finisher:(FLFinisher*) finisher;
//@end
//
//@protocol FLAsyncMessageSender <NSObject>
//- (BOOL) sendAsyncMessage:(id<FLAsyncMessage>) message
//          finisher:(FLFinisher*) finisher;
//@end

@interface FLFinisher ()
@property (readwrite, assign) BOOL isFinished;
@end

@implementation FLFinisher

@synthesize isFinished = _finished;

synthesize_(input);
synthesize_(output);
synthesize_(error);
synthesize_(notificationScheduler)

- (void) addFinisher:(FLFinisher*) finisher {
    if(!_finishers) {
        _finishers = [[NSMutableArray alloc] init]; 
    }
    
    [_finishers addObject:finisher];
}

dealloc_(
    [_input release];
    [_output release];
    [_error release];
    [_finishers release];
    if(_notificationScheduler) {
        [_notificationScheduler release];
    }
    [super dealloc];
)
+ (id) finisher {
    return autorelease_([[[self class] alloc] init]);
}

//- (BOOL) hasResult {
//    return self.isFinished;
//}
//
//- (void) setFinishedWithSuccess:(BOOL) success {
//    if(success) {
//        [self setFinishedWithResult:[FLSuccessfullResult instance]];
//    }
//    else {
//        [self setFinishedWithResult:[FLFailedResult instance]];
//    }
//}
//
//- (void) setFinished {
//    [self setFinishedWithResult:[FLSuccessfullResult instance]];
//}
//
//- (void) setFinishedWithError:(NSError*) error {
//    if(error) {
//        [self setFinishedWithResult:[FLErrorResult errorResult:error]];
//    }
//    else {
//        [self setFinishedWithResult:[FLFailedResult instance]];
//    }
//}
//
//- (void) setFinishedWithOutput:(id) output {
//    if(output) {
//        [self setFinishedWithResult:[FLOutputResult outputResult:output]];
//    }
//    else {
//        [self setFinishedWithResult:[FLSuccessfullResult instance]];
//    }
//}

- (BOOL) didSucceed {
    return self.isFinished && self.error == nil;
}

- (void) didFinish {
}

- (void) setFinishedWithFinisher:(FLFinisher*) finisher {
    self.output = finisher.output;
    self.error = finisher.error;
    [self setFinished];
}

- (void) setFinished {

    if(_notificationScheduler) {
        FLFinisherNotificationScheduler scheduler = _notificationScheduler;
        mrc_retain_(scheduler);
        self.notificationScheduler = nil;

        scheduler(self);

        release_(scheduler);
        return;
    }

    FLAssert_v(_finished == NO, @"already finished");

    self.isFinished = YES;
    
    [self didFinish];

    if(_finishers) {
        for(FLFinisher* finisher in _finishers) {
            finisher.output = self.output;
            finisher.error = self.error;
        
            [finisher setFinished];
        }
    }
}

- (FLFinisher*) waitUntilFinished {

// this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
// and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
    mrc_retain_(self);
    @try {
        while(!self.isFinished) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
        }
    }
    @finally {
        mrc_autorelease_(self);
    }

    return self;
}

- (void) setFinishedWithError:(NSError*) error {
    self.error = error;
    [self setFinished];
}
- (void) setFinishedWithOutput:(id) output {
    self.output = output;
    [self setFinished];
}


@end

@implementation FLBlockFinisher 

- (id) initWithAsyncBlock:(FLAsyncBlock) completion {
    
    self = [super init];
    if(self) {
        if(completion) {
            _finishBlock = [completion copy];
        }
    }
    return self;
}

+ (id) finisher:(FLAsyncBlock) completion {
    return autorelease_([[[self class] alloc] initWithAsyncBlock:completion]);
}

dealloc_(
    if(_finishBlock) {
        [_finishBlock release];
    }
    [super dealloc];
)

- (void) didFinishWithResult:(FLFinisher*) result {
    if(_finishBlock) {
        _finishBlock(result);
    }
}

@end

@implementation FLTargetFinisher

- (id) initWithTarget:(id) target action:(SEL) action {
    self = [super init];
    if(self) {
        _target = target;
        _action = action;
    }
    return self;
}

+ (id) finisherWithTarget:(id) target action:(SEL) action{
    return autorelease_([[[self class] alloc] initWithTarget:target action:action]);
}

- (void) didFinishWithResult:(FLFinisher*) result  {
    FLPerformSelector1(_target, _action, result);
}


@end

