//
//	GtCancellableOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

@protocol GtCancellableOperation <NSObject>
 // should be atomic 
@property (readonly, assign) BOOL wasCancelled; // needs to be atomic.
- (void) requestCancel; 

// this only makes sense within the scope of the executing thread.
// it does NOT throw across threads.
- (void) throwIfCancelled;
@end

@interface GtCancellableOperation : NSObject<GtCancellableOperation> {
@private 
	BOOL m_cancelled;
}
@property (readwrite, assign) BOOL wasCancelled; // needs to be atomic.
@end