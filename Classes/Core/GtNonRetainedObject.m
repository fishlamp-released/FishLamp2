//
//  GtNonRetainedObject.m
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/5/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtNonRetainedObject.h"

@implementation GtNonRetainedObject

@synthesize object = _object;

GtAssertDefaultInitNotCalled();

- (id) initWithObject:(id) object {
	GtAssertNotNil(object);

	if((self = [super init])) {
		_object = object;
	}
	
	return self;
}

+ (GtNonRetainedObject*) nonRetainedObject:(id) object {
	return GtReturnAutoreleased([[GtNonRetainedObject alloc] initWithObject:object]);
}

- (NSString*) description {
	return [NSString stringWithFormat:@"GtNonRetainedObject holding a %@:\n%@", NSStringFromClass([_object class]), [_object description]];
}

- (BOOL)isEqual:(id)object {
	return [_object isEqual:object];
}

- (NSUInteger)hash {
	return [_object hash];
}

@end
