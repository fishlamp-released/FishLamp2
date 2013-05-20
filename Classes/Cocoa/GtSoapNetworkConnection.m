//
//	GtSoapNetworkConnection.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/18/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSoapNetworkConnection.h"

@implementation GtSoapNetworkConnection

@synthesize apiNamespace = m_apiNamespace;
@synthesize soapActionHeader = m_soapActionHeader;
@synthesize soapBuilder = m_soap;

- (id) initWithURL:(NSURL*) url
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace
{
	GtAssertIsValidString(soapActionHeader);
	GtAssertIsValidString(apiNamespace);
	
	if((self = [super initWithHttpRequest:[GtHttpRequest httpRequestWithURL:url requestMethod:@"POST"]]))
	{
		self.apiNamespace = apiNamespace;
		self.soapActionHeader = soapActionHeader;
		m_soap = [[GtSoapBuilder alloc] initWithPrettyPrint:NO];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_apiNamespace);
	GtRelease(m_soapActionHeader);
	GtRelease(m_soap);
	GtSuperDealloc();
}

- (void) prepareRequest
{
	[super prepareRequest];
	[self.httpRequest setHeader:@"SOAPAction" data:[NSString stringWithFormat:@"\"%@\"", self.soapActionHeader]];
	[self.httpRequest setUtf8Content:[m_soap buildString]];
}

- (NSString*) description
{
	return [NSString stringWithFormat:@"url:%@\npostHeader:%@\nsoapActionHeader:%@\napiNamespace:%@\nsoap:\n%@\n",
		self.httpRequest.requestUrl,
		self.httpRequest.postHeader,
		m_soapActionHeader,
		m_apiNamespace,
		[m_soap description]];
}

+ (GtSoapNetworkConnection*) soapRequest:(NSURL*) url 
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace
{
	return GtReturnAutoreleased([[GtSoapNetworkConnection alloc] initWithURL:url soapActionHeader:soapActionHeader soapApiNamespace:apiNamespace]);
}

@end

@implementation GtHttpOperation (Soap)

- (NSString*) operationName
{
	return nil;
}

@end