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
@property (readwrite, assign) BOOL finishedSynchronously;
@end

@implementation FLFinisher

synthesize_(result);
synthesize_(notificationScheduler)
synthesize_(finishedSynchronously)

+ (id) finisherWithResultBlock:(FLResultBlock) completion {
    return autorelease_([[[self class] alloc] initWithResultBlock:completion]);
}

- (id) initWithResultBlock:(FLResultBlock) completion {
    
    self = [super init];
    if(self) {
        if(completion) {
            _startThread = [NSThread currentThread];
            _resultNotificationBlock = [completion copy];
        }
    }
    return self;
}

- (id) initWithTarget:(id) target action:(SEL) action {
    self = [super init];
    if(self) {
        _startThread = [NSThread currentThread];
        _resultNotificationTarget = target;
        _resultNotificationAction = action;
    }
    return self;
}

+ (id) finisherWithTarget:(id) target action:(SEL) action{
    return autorelease_([[[self class] alloc] initWithTarget:target action:action]);
}

- (void) addSubFinisher:(FLFinisher*) finisher {
    if(!_subFinishers) {
        _subFinishers = [[NSMutableArray alloc] init]; 
    }
    
    [_subFinishers addObject:finisher];
}

- (BOOL) isFinished {
    return self.result != nil;
}

dealloc_(
    if(_resultNotificationBlock) {
        [_resultNotificationBlock release];
    }
    if(_notificationScheduler) {
        [_notificationScheduler release];
    }
    [_result release];
    [_subFinishers release];
    [super dealloc];
)

+ (id) finisher {
    return autorelease_([[[self class] alloc] init]);
}

//- (BOOL) didSucceed {
//    return self.isFinished && ![self.result isError];
//}

- (void) didFinish {
    if(_resultNotificationBlock) {
        _resultNotificationBlock(self.result);
    }
    FLPerformSelector1(_resultNotificationTarget, _resultNotificationAction, self.result);
}

- (void) finalizeFinish {
    [self didFinish];

    if(_subFinishers) {
        for(FLFinisher* finisher in _subFinishers) {
            [finisher setFinishedWithResult:self.result];
        }
    }
}

- (void) scheduleFinish {
    
    self.finishedSynchronously = ([NSThread currentThread] == _startThread);

    if(_notificationScheduler) {
        FLFinisherNotificationScheduler scheduler = _notificationScheduler;
        mrc_retain_(scheduler);
        self.notificationScheduler = nil;

        scheduler(^{ 
            [self finalizeFinish]; 
        });

        release_(scheduler);
    }
    else {
        [self finalizeFinish];
    }
}

- (void) waitUntilFinished {

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


