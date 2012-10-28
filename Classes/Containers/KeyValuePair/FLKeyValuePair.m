//
//	OMKeyValuePair.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/19/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLKeyValuePair.h"

@implementation FLKeyValuePair

@synthesize key = _key;
@synthesize value = _value;

- (id) initWithKey:(id) key value:(id) value {
	self.key = key;
	self.value = value;
	return self;
}

+ (FLKeyValuePair*) keyValuePair:(id) key value:(id) value {
	return FLReturnAutoreleased([[FLKeyValuePair alloc] initWithKey:key value:value]);
}

#if FL_NO_ARC
- (void) dealloc {
    FLRelease(_key);
    FLRelease(_value);
	FLSuperDealloc();
}
#endif


@end
