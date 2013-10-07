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
#import "FLPromise.h"

@protocol FLFinisherDelegate;

@interface FLFinisher : FLPromise {
@private
    __unsafe_unretained id<FLFinisherDelegate> _delegate;

#if DEBUG
    NSTimeInterval _birth;
#endif
}

// TODO (MWF): get rid of this.
@property (readwrite, assign) id<FLFinisherDelegate> delegate;

+ (id) finisher;
+ (id) finisherWithBlock:(fl_completion_block_t) completion;
+ (id) finisherWithTarget:(id) target action:(SEL) action;

// notify finished
- (void) setFinishedWithResult:(FLPromisedResult) result;

// convienience methods - these call setFinishedWithResult:error
- (void) setFinished;
- (void) setFinishedWithCancel;

@end

@protocol FLFinisherDelegate <NSObject>
- (void) finisherDidFinish:(FLFinisher*) finisher
                withResult:(FLPromisedResult) resultOrNil;
@end