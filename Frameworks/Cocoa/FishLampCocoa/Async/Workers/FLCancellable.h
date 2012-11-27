//
//	FLCancellable.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "FLResult.h"
@class FLFinisher;

typedef void (^FLCancelBlock)();

@protocol FLCancellable <NSObject>

@property (readonly, assign,getter=wasCancelled) BOOL cancelled; 

@property (readonly, assign) BOOL cancelWasRequested; 

- (FLFinisher*) requestCancel:(FLResultBlock) completion; 

@end

