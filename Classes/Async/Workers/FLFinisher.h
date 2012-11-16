//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLResult.h"

@class FLFinisher;

typedef void (^FLFinisherNotificationScheduler)(dispatch_block_t finishBlock);
typedef void (^FLCompletionBlock)();
typedef void (^FLAsyncBlock)(FLFinisher* finisher);

@interface FLFinisher : NSObject {
@private
    NSMutableArray* _finishers;
    FLFinisherNotificationScheduler _notificationScheduler;
    id _result;
    FLResultBlock _finishBlock;
    __unsafe_unretained id _target;
    SEL _action;
}

@property (readwrite, copy) FLFinisherNotificationScheduler notificationScheduler;

// isFinished && error == nil
@property (readonly, assign) BOOL didSucceed; 
@property (readonly, assign) BOOL isFinished;
@property (readonly, strong) id result;

- (id) initWithAsyncBlock:(FLResultBlock) resultBlock;
- (id) initWithTarget:(id) target action:(SEL) action; // myMethod:(FLFinisher*) result;

+ (id) finisher;
+ (id) finisherWithBlock:(FLResultBlock) block;
+ (id) finisherWithTarget:(id) target action:(SEL) action;

- (void) addFinisher:(FLFinisher*) finisher;

- (void) setFinished;
- (void) setFinishedWithResult:(id) result;

// override point
- (void) didFinish;

// blocks in current thread
- (id) waitUntilFinished;
@end
