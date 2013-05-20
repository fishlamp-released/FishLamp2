//
//	GtSoapBuilder.m
//	FishLamp
//
//	Created By Mike Fullerton on 4/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSoapBuilder.h"
#import "GtSoapDataEncoder.h"
#import "NSObject+XML.h"

@implementation GtSoapBuilder

-(id) init
{
	return [self initWithPrettyPrint:NO];
}

- (id) initWithPrettyPrint:(BOOL) prettyPrint
{
	if((self = [super initWithPrettyPrint:prettyPrint]))
	{
		self.dataEncoder = [GtSoapDataEncoder instance];

		[self addVersionAndEncodingHeader];
		
		// TODO: Not sure if these attributes are okay to be hardcoded?
		[self pushAttributeString:@"http://www.w3.org/2001/XMLSchema-instance" attributeName:@"xmlns:xsi"];
		[self pushAttributeString:@"http://www.w3.org/2001/XMLSchema" attributeName:@"xmlns:xsd"];
		[self pushAttributeString:@"http://schemas.xmlsoap.org/soap/envelope/" attributeName:@"xmlns:soap"];
// xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
		[self openElement:@"soap:Envelope"];
		[self openElement:@"soap:Body"];
	}
	return self;
}

-(NSString*) buildString
{
	[self closeElement]; // Body
	[self closeElement]; // Envelope
	
	return [super buildString];
}

- (NSString*) encodeString:(NSString*) string
{
	return [string xmlEncode];
}

- (void) addObjectAsFunction:(NSString*) functionName object:(id) object namespace:(NSString*) namespace
{
	[self pushAttributeString:namespace attributeName:@"xmlns"];
	[self openElement:functionName];

#if NEW_BUILDER
	[self addObjectAsXML:object];
#else
	[self streamObject:object];
#endif
	[self closeElement];
}

- (void) addSoapParameter:(NSString*) name data:(NSString*) data
{
	[self addElementWithStringValue:data elementName:name];
}

- (void) addSoapParameters:(NSDictionary*) parameters
{
	for(NSString* key in parameters)
	{
		[self addSoapParameter:key data:[parameters valueForKey:key]];
	}
}


@end
