//
//  GtSoapRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 4/18/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtSoapRequest.h"
#import "GtSerializableObject.h"
#import "GtFileUtilities.h"

//#import "ISO8601DateFormatter.h"

@implementation GtSoapRequest

GtSynthesizeString(apiNamespace, setApiNamespace);
GtSynthesizeString(soapActionHeader, setSoapActionHeader);

@synthesize soapBuilder = m_soap;

- (id) initWithSoapInfo:(NSString*) url
	postHeader:(NSString*) postHeader
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace
{
	GtAssertIsValidString(url);
	GtAssertIsValidString(postHeader);
	GtAssertIsValidString(soapActionHeader);
	GtAssertIsValidString(apiNamespace);
	
	if(self = [super initPostRequestWithUrl:url postHeader:postHeader])
	{
		self.apiNamespace = apiNamespace;
		self.soapActionHeader = soapActionHeader;
		
		m_soap = [GtAlloc(GtSoapBuilder) initWithPrettyPrint:NO];
		
		if(self.apiNamespace && self.apiNamespace.length)
		{
			[m_soap pushAttribute:@"xmlns" data:self.apiNamespace];
		}
	}
	return self;
}

- (void) dealloc
{
	[m_apiNamespace release];
	[m_soapActionHeader release];
	[m_soap release];
	
	[super dealloc];
}

- (void) addObjectAsFunction:(NSString*) functionName object:(GtSerializableObject*) object
{
	[object toXml:m_soap withRootElement:functionName];
}

- (void) addSoapParameter:(NSString*) name data:(NSString*) data
{
	[m_soap addClosedElement:name data:data];
}

- (void) addSoapParameters:(NSDictionary*) parameters
{
	for(NSString* key in parameters)
	{
		[self addSoapParameter:key data:[parameters valueForKey:key]];
	}
}

+ (NSString*) formatPostHeader:(NSString*) webServiceRelativeUrl
{
	return [NSString stringWithFormat:@"/%@ HTTP/1.1", webServiceRelativeUrl];
}

- (void) send
{
	NSString* content = nil;
	NSString* quotedSoapAction = nil;
	@try
	{
		content = [m_soap toString];
		quotedSoapAction = [GtAlloc(NSString) initWithFormat:@"\"%@\"", self.soapActionHeader];
	
		[self addBasicHeaders];
		[self setUtf8Content:content];
		[self addHeader:@"SOAPAction" data:quotedSoapAction];
		
		[super send];
	}
	@finally
	{	
		GtRelease(quotedSoapAction);
	}
}

- (NSString*) description
{
	return [NSString stringWithFormat:@"host: %@\nurl:%@\npostHeader:%@\nsoapActionHeader:%@\napiNamespace:%@\nsoap:\n%@\n",
		[self host],
		self.url,
		[self postHeader],
		m_soapActionHeader,
		m_apiNamespace,
		[m_soap description]];
}

@end

