//
//  FLNonRetainedObject.m
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLNonRetainedObject.h"

@implementation FLNonRetainedObject

@synthesize object = _object;

FLAssertDefaultInitNotCalled_();

- (id) initWithObject:(id) object {
	FLAssertIsNotNil_v(object, nil);

	if((self = [super init])) {
		_object = object;
	}
	
	return self;
}

+ (FLNonRetainedObject*) nonRetainedObject:(id) object {
	return FLAutorelease([[FLNonRetainedObject alloc] initWithObject:object]);
}

- (NSString*) description {
	return [NSString stringWithFormat:@"FLNonRetainedObject holding a %@:\n%@", NSStringFromClass([_object class]), [_object description]];
}

- (BOOL)isEqual:(id)object {
	return [_object isEqual:object];
}

- (NSUInteger)hash {
	return [_object hash];
}

@end
