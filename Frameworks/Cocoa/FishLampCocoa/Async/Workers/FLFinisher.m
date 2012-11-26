//
//  FLFinisher.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFinisher.h"
#import "FLDispatchQueue.h"

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
@property (readwrite, strong) FLResult result;
@end

@implementation FLFinisher

@synthesize requestCancelBlock = _requestCancelBlock;
@synthesize result = _result;
@synthesize notificationScheduler = _notificationScheduler;

+ (id) finisherWithResultBlock:(FLResultBlock) completion {
    return autorelease_([[[self class] alloc] initWithResultBlock:completion]);
}

- (id) initWithResultBlock:(FLResultBlock) completion {
    
    self = [super init];
    if(self) {
        if(completion) {
            _resultNotificationBlock = [completion copy];
        }
    }
    return self;
}

- (id) initWithTarget:(id) target action:(SEL) action {
    self = [super init];
    if(self) {
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

#if FL_MRC
- (void) dealloc {
    if(_resultNotificationBlock) {
        [_resultNotificationBlock release];
    }
    if(_notificationScheduler) {
        [_notificationScheduler release];
    }
    if(_requestCancelBlock) {
        [_requestCancelBlock release];
    }
    [_result release];
    [_subFinishers release];
    
    super_dealloc_();
}
#endif

+ (id) finisher {
    return autorelease_([[[self class] alloc] init]);
}

- (BOOL) requestCancel:(dispatch_block_t) cancelCompletionOrNil {
    if(_requestCancelBlock) {
        _requestCancelBlock();
        return YES;
    }
    
    return NO;
}

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

- (void) waitOnce {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
}

- (FLResult) waitUntilFinished {

// this may not work in all cases - e.g. some iOS apis expect to be called in the main thread
// and this will cause endless blocking, unfortunately. I've seen this is the AssetLibrary sdk.
    mrc_retain_(self);
    @try {
        while(!self.isFinished) {
            [self waitOnce];
        }
    }
    @finally {
        mrc_autorelease_(self);
    }
    
    return self.result;
}

- (void) setFinished {
    FLAssertIsNil_v(self.result, @"already finished");
    self.result = FLSuccessfullResult;
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
    
    FLAssertNotNil_(self.result);
}

- (void) scheduleFinishOnMainThread {

    static FLFinisherNotificationScheduler s_block = ^(dispatch_block_t finishBlock) {
        if(finishBlock) {
            if(![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    finishBlock();
                });    
            }
            else {
                finishBlock();
            }
        }
    };    

    self.notificationScheduler = s_block;
}


@end


