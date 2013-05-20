//
//  FLFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLAsyncResult.h"
#import "FLDispatchTypes.h"

#if DEBUG
#import "FLStackTrace.h"
#endif

#import "FLPromise.h"

@protocol FLFinisherDelegate;

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
- (void) setFinished;
- (void) setFinishedWithResult:(FLPromisedResult) result; 

- (void) setFinishedWithCancel;

@end

@protocol FLFinisherDelegate <NSObject>
- (void) finisher:(FLFinisher*) finisher didFinishWithResult:(id) result; 
@end