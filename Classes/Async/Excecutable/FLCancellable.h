//
//	FLCancellable.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"

@protocol FLCancellable <NSObject>
 // should be atomic 
@property (readonly, assign) BOOL wasCancelled; // needs to be atomic.
- (void) requestCancel; 
@end

// this only makes sense within the scope of the executing thread.
// it does NOT throw across threads.

NS_INLINE
void FLThrowIfCancelled(id object) {
    
    if([object wasCancelled]) {
   		FLCThrowError_([NSError cancelError]);
    }
}