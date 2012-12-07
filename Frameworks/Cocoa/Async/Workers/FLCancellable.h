//
//	FLCancellable.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FLCore.h"
#import "FLResult.h"
#import "FLObservable.h"

@class FLFinisher;

typedef void (^FLCancelBlock)();

@protocol FLCancellable <NSObject>
- (FLFinisher*) requestCancel:(FLResultBlock) completion; 
@end

@interface FLCancellable : NSObject<FLCancellable> {
@private
    NSMutableArray* _cancelled;
    NSMutableArray* _dependents;
    BOOL _wasCancelled;
}

+ (id) cancelHandler;

@property (readonly, assign) BOOL wasCancelled;

- (void) reset;
- (FLResult) setFinished:(FLResult) result;

- (void) addDependent:(id<FLCancellable>) dependent;
- (void) removeDependent:(id<FLCancellable>) dependent;

- (FLResult) runBlock:(FLResult (^)()) block 
         forDependent:(id<FLCancellable>) dependent;

@end