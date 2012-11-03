//
//	FLObjectParser.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLObjectInflatorState.h"

@implementation FLObjectInflatorState

@synthesize key = _key;
@synthesize object = _object;
@synthesize data = _data;
@synthesize objectDescriber = _describer;
@synthesize parsedDataType = _dataType;
@synthesize dataIsAttribute = _dataIsAttribute;
@synthesize parseInfo = _parseInfo;

- (id) init {
	if((self = [super init])) {
		self.parsedDataType = FLDataTypeUnknown;
	}
	
	return self;
}

- (id) initWithObject:(id) object key:(id) key {
    self = [super init];
    if(self) {
        self.object = object;
        self.key = key;
    }
    return self;
}

+ (FLObjectInflatorState*) objectInflatorState:(id) object key:(id) key {
    return autorelease_([[FLObjectInflatorState alloc] initWithObject:object key:key]);
}

- (void) dealloc {
    mrc_release_(_parseInfo);
	mrc_release_(_describer);
	mrc_release_(_object);
	mrc_release_(_key);
	mrc_release_(_data);
	super_dealloc_();
}

@end
