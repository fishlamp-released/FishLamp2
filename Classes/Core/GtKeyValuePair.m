//
//	GtKeyValuePair.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/19/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtKeyValuePair.h"

@implementation GtKeyValuePair

@synthesize key = _key;
@synthesize value = _value;

- (id) initWithKey:(id) key value:(id) value {
	self.key = key;
	self.value = value;
	return self;
}

+ (GtKeyValuePair*) keyValuePair:(id) key value:(id) value {
	return GtReturnAutoreleased([[GtKeyValuePair alloc] initWithKey:key value:value]);
}

#if GT_DEALLOC
- (void) dealloc {
    [_key release];
    [_value release];
	[super dealloc];
}
#endif


@end
