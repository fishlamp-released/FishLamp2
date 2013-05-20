//
//	GtRetainedObject.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtRetainedObject.h"


@implementation GtRetainedObject

@synthesize object = _object;

- (id) initWithObject:(id) object {
	self.object = object;
	return self;
}

+ (GtRetainedObject*) retainedObject:(id) object {
	return GtReturnAutoreleased([[GtRetainedObject alloc] initWithObject:object]);
}

#if GT_DEALLOC
- (void) dealloc {
    [_object release];
	[super dealloc];
}
#endif



@end
