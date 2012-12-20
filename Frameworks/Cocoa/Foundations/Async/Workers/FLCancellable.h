//
//	FLCancellable.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FLCore.h"
#import "FLResult.h"

@class FLFinisher;

typedef void (^FLCancelBlock)();

@protocol FLCancellable <NSObject>
- (void) requestCancel; 
@end

@interface FLCancellable : NSObject<FLCancellable> {
@private
    NSMutableArray* _dependents;
}

+ (id) cancelHandler;

- (void) addDependent:(id<FLCancellable>) dependent;
- (void) removeDependent:(id<FLCancellable>) dependent;

//- (FLResult) runBlock:(FLResult (^)()) block 
//         forDependent:(id<FLCancellable>) dependent;

@end