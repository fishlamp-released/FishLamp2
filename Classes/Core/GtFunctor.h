//
//	GtFunctor.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/30/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampMinimum.h"
#import "GtCallbackObject.h"

@interface GtFunctor : GtCallbackObject {
}

// override this.
- (void) doPerformCallback:(id) sender;

@end

