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
	return autorelease_([[FLRetainedObject alloc] initWithObject:object]);
}

#if FL_MRC
- (void) dealloc {
    mrc_release_(_object);
	super_dealloc_();
}
#endif



@end
