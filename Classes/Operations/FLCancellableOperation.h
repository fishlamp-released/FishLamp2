//
//	FLCancellableOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"

@protocol FLCancellableOperation <NSObject>
 // should be atomic 
@property (readonly, assign) BOOL wasCancelled; // needs to be atomic.
- (void) requestCancel; 

// this only makes sense within the scope of the executing thread.
// it does NOT throw across threads.
- (void) throwIfCancelled;
@end

@interface FLCancellableOperation : NSObject<FLCancellableOperation> {
@private 
	BOOL _cancelled;
}
@property (readwrite, assign) BOOL wasCancelled; // needs to be atomic.
@end