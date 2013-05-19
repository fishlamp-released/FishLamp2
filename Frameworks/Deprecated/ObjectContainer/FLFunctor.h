//
//	FLFunctor.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/30/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
#import "FLCallbackObject.h"

@interface FLFunctor : FLCallbackObject {
}

// override this.
- (void) doPerformCallback:(id) sender;

@end

