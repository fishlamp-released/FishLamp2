//
//	FLNetworkEndpointHelper.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLNetworkServerContext.h"
#import "FLHttpOperation.h"
#import "FLOperationAuthenticator.h"

@implementation FLNetworkServerContext

@synthesize defaultNetworkRequestFactory = _defaultNetworkRequestFactory;
@synthesize authenticator = _authenticator;
@synthesize defaultNetworkOperationResponseHandler = _defaultResponseHandler;
@synthesize properties = _properties;

- (id) init {
	if((self = [super init])) {
		_properties = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void) dealloc {
	FLRelease(_properties);
	FLRelease(_defaultNetworkRequestFactory);
	FLRelease(_defaultResponseHandler);
	FLRelease(_authenticator);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder {
}

- (id) initWithCoder:(NSCoder*) aDecoder {
	return [self init];
}


@end

