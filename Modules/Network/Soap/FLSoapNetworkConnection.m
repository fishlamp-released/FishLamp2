//
//	FLSoapNetworkConnection.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/18/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLSoapNetworkConnection.h"
#import "_FLNetworkConnection.h"

@implementation FLSoapNetworkConnection

@synthesize apiNamespace = _apiNamespace;
@synthesize soapActionHeader = _soapActionHeader;
@synthesize soapBuilder = _soap;

- (id) initWithURL:(NSURL*) url
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace
{
	FLAssertStringIsNotEmpty(soapActionHeader);
	FLAssertStringIsNotEmpty(apiNamespace);
	
	if((self = [super initWithHttpRequest:[FLHttpRequest httpRequestWithURL:url requestMethod:@"POST"]]))
	{
		self.apiNamespace = apiNamespace;
		self.soapActionHeader = soapActionHeader;
		_soap = [[FLSoapBuilder alloc] init];
	}
	return self;
}

- (void) dealloc
{
	FLRelease(_apiNamespace);
	FLRelease(_soapActionHeader);
	FLRelease(_soap);
	FLSuperDealloc();
}

- (void) openNetworkStreams
{
	[self.httpRequest setHeader:@"SOAPAction" data:[NSString stringWithFormat:@"\"%@\"", self.soapActionHeader]];
    NSString* soap = [_soap buildString];
	[self.httpRequest setUtf8Content:soap];
    [super openNetworkStreams];
}

- (NSString*) description
{
	return [NSString stringWithFormat:@"url:%@\npostHeader:%@\nsoapActionHeader:%@\napiNamespace:%@\nsoap:\n%@\n",
		self.httpRequest.requestUrl,
		self.httpRequest.postHeader,
		_soapActionHeader,
		_apiNamespace,
		[_soap description]];
}

+ (FLSoapNetworkConnection*) soapRequest:(NSURL*) url 
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace
{
	return FLReturnAutoreleased([[FLSoapNetworkConnection alloc] initWithURL:url soapActionHeader:soapActionHeader soapApiNamespace:apiNamespace]);
}

@end

@implementation FLHttpOperation (Soap)

- (NSString*) operationName
{
	return nil;
}

@end