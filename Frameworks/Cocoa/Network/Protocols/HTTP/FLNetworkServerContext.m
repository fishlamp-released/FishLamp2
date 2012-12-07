//
//	FLNetworkEndpointHelper.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLNetworkServerContext.h"
#import "FLHttpOperation.h"
#import "FLNetworkConnectionAuthenticator.h"

@implementation FLNetworkServerContext

@synthesize properties = _properties;

- (id) init {
	if((self = [super init])) {
		_properties = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void) dealloc {
	FLRelease(_properties);
	super_dealloc_();
}

// stubs in case parents call [super ...]

- (void) encodeWithCoder:(NSCoder*) aCoder {
}

- (id) initWithCoder:(NSCoder*) aDecoder {
	return [self init];
}


@end

