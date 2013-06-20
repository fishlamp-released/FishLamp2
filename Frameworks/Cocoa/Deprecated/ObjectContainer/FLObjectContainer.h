//
//	FLObjectContainer.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"

@protocol FLObjectContainer <NSObject>
- (id) object;
- (void) setObject:(id) object;
@end


