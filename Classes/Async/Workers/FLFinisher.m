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
@property (readwrite, strong) id result;
@end

@implementation FLFinisher

synthesize_(result);
synthesize_(notificationScheduler)

+ (id) finisherWithBlock:(FLResultBlock) completion {
    return autorelease_([[[self class] alloc] initWithAsyncBlock:completion]);
}

- (id) initWithAsyncBlock:(FLResultBlock) completion {
    
    self = [super init];
    if(self) {
        if(completion) {
            _finishBlock = [completion copy];
        }
    }
    return self;
}

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

- (void) addFinisher:(FLFinisher*) finisher {
    if(!_finishers) {
        _finishers = [[NSMutableArray alloc] init]; 
    }
    
    [_finishers addObject:finisher];
}

- (BOOL) isFinished {
    return self.result != nil;
}

dealloc_(
    if(_finishBlock) {
        [_finishBlock release];
    }
    if(_notificationScheduler) {
        [_notificationScheduler release];
    }
    [_result release];
    [_finishers release];
    [super dealloc];
)

+ (id) finisher {
    return autorelease_([[[self class] alloc] init]);
}

- (BOOL) didSucceed {
    return self.isFinished && ![self.result isError];
}

- (void) didFinish {
    if(_finishBlock) {
        _finishBlock(self.result);
    }
    FLPerformSelector1(_target, _action, self.result);
}

- (void) finalizeFinish {
    [self didFinish];

    if(_finishers) {
        for(FLFinisher* finisher in _finishers) {
            [finisher setFinishedWithResult:self.result];
        }
    }
}

- (void) scheduleFinish {
    if(_notificationScheduler) {
        FLFinisherNotificationScheduler scheduler = _notificationScheduler;
        mrc_retain_(scheduler);
        self.notificationScheduler = nil;

        scheduler(^{ [self finalizeFinish]; });

        release_(scheduler);
    }
    else {
        [self finalizeFinish];
    }
    
}

- (id) waitUntilFinished {

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

    return self.result;
}

- (void) setFinished {
    FLAssertIsNil_v(self.result, @"already finished");
    self.result = [FLSuccessfullResult successfulResult];
    [self scheduleFinish];
}

- (void) setFinishedWithResult:(id) result {

    if(result) {
        FLAssertIsNil_v(self.result, @"already finished");
        self.result = result;
        [self scheduleFinish];
    }
    else {
        [self setFinished];
    }
}

@end


