//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
#import "FLAsyncBlockTypes.h"
#import "FLPromisedResult.h"

@protocol FLFinisherDelegate;
@class FLPromise;

@interface FLFinisher : NSObject {
@private
    FLPromise* _firstPromise;
    __unsafe_unretained id<FLFinisherDelegate> _delegate;
}

@property (readwrite, assign) id<FLFinisherDelegate> delegate;
@property (readonly, assign) BOOL willFinish;
@property (readonly, strong) FLPromise* firstPromise;

+ (id) finisher;
+ (id) finisherWithBlock:(fl_completion_block_t) completion;
+ (id) finisherWithTarget:(id) target action:(SEL) action;
+ (id) finisherWithPromise:(FLPromise*) promise;

- (FLPromise*) addPromise;
- (FLPromise*) addPromiseWithBlock:(fl_completion_block_t) completion;
- (FLPromise*) addPromiseWithTarget:(id) target action:(SEL) action;

- (void) addPromise:(FLPromise*) promise;

// notify finish with one of these

// convienience methods - these call setFinishedWithResult:error
- (void) setFinished;
- (void) setFinishedWithResult:(FLPromisedResult) result;

- (void) setFinishedWithCancel;

@end

@protocol FLFinisherDelegate <NSObject>
- (void) finisherDidFinish:(FLFinisher*) finisher
                withResult:(FLPromisedResult) resultOrNil;
@end