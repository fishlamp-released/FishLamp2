//
//	FLFunctor.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/30/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCore.h"
#import "FLCallbackObject.h"

@interface FLFunctor : FLCallbackObject {
}

// override this.
- (void) doPerformCallback:(id) sender;

@end

