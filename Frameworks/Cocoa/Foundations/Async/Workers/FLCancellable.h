//
//	FLCancellable.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FLCore.h"

@protocol FLCancellable <NSObject>
- (void) requestCancel; 
@end

