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
	mrc_release_(_properties);
	mrc_release_(_defaultNetworkRequestFactory);
	mrc_release_(_defaultResponseHandler);
	mrc_release_(_authenticator);
	mrc_super_dealloc_();
}

- (void) encodeWithCoder:(NSCoder*) aCoder {
}

- (id) initWithCoder:(NSCoder*) aDecoder {
	return [self init];
}


@end

