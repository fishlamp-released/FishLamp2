//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLFinisher;

typedef void (^FLFinisherNotificationScheduler)(FLFinisher* theFinisher);
typedef void (^FLAsyncBlock)(FLFinisher* finisher);

typedef void (^FLCompletionBlock)();

@interface FLFinisher : NSObject {
@private
    BOOL _finished;
    NSMutableArray* _finishers;
    FLFinisherNotificationScheduler _notificationScheduler;
    
    NSError* _error;
    id _input;
    id _output;
}

@property (readwrite, copy) FLFinisherNotificationScheduler notificationScheduler;

// isFinished && error == nil
@property (readonly, assign) BOOL didSucceed; 

@property (readonly, assign) BOOL isFinished;
- (void) setFinished;
- (void) setFinishedWithError:(NSError*) error;
- (void) setFinishedWithOutput:(id) output;
- (void) setFinishedWithFinisher:(FLFinisher*) finisher;

@property (readwrite, strong) NSError* error;
@property (readwrite, strong) id input;
@property (readwrite, strong) id output;

+ (id) finisher;

- (void) addFinisher:(FLFinisher*) finisher;

// override point
- (void) didFinish;

- (FLFinisher*) waitUntilFinished;


@end

@interface FLBlockFinisher : FLFinisher {
@private
    FLAsyncBlock _finishBlock;
}
- (id) initWithAsyncBlock:(FLAsyncBlock) resultBlock;
+ (id) finisher:(FLAsyncBlock) completion;
@end

@interface FLTargetFinisher : FLFinisher {
@private
    __unsafe_unretained id _target;
    SEL _action;
}
- (id) initWithTarget:(id) target action:(SEL) action; // myMethod:(FLFinisher*) result;
+ (id) finisherWithTarget:(id) target action:(SEL) action;

@end