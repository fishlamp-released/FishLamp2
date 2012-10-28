//
//	FLRetainedObject.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLRetainedObject.h"


@implementation FLRetainedObject

@synthesize object = _object;

- (id) initWithObject:(id) object {
	self.object = object;
	return self;
}

+ (FLRetainedObject*) retainedObject:(id) object {
	return FLReturnAutoreleased([[FLRetainedObject alloc] initWithObject:object]);
}

#if FL_NO_ARC
- (void) dealloc {
    FLRelease(_object);
	FLSuperDealloc();
}
#endif



@end
