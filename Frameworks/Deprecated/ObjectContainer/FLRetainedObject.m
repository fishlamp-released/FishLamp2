//
//	FLRetainedObject.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLRetainedObject.h"


@implementation FLRetainedObject

@synthesize object = _object;

- (id) initWithObject:(id) object {
	self.object = object;
	return self;
}

+ (FLRetainedObject*) retainedObject:(id) object {
	return FLAutorelease([[FLRetainedObject alloc] initWithObject:object]);
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_object);
	FLSuperDealloc();
}
#endif



@end
