//
//	GtSoapParser.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/11/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSoapParser.h"
#import "NSString+XML.h"
#import "GtSoapDataEncoder.h"

@implementation GtSoapParser

- (id) initWithXmlData:(NSData*) data
{
	if((self = [super initWithXmlData:data]))
	{
		self.dataDecoder = [GtSoapDataEncoder instance];
	}
	
	return self;
}

+ (NSString*) stringWithDeletedNamespacePrefix:(NSString*) elementName
{
	NSRange prefix = [elementName rangeOfString:@":"];
	return prefix.length > 0 ? [elementName substringFromIndex:prefix.location+1] : elementName;
}

- (void) onConfigureParser:(NSXMLParser*) parser
{
	[parser setShouldProcessNamespaces:YES];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
	attributes:(NSDictionary *)attributeDict
{
	if(!m_soapFlags.foundEnvelope && [elementName isEqualToString:@"Envelope"])
	{
		m_soapFlags.foundEnvelope = YES;
	}
	else if(!m_soapFlags.foundBody && [elementName isEqualToString:@"Body"])
	{
		m_soapFlags.foundBody = YES;
	}
	else
	{
		[super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
	}
}
- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
	if(![elementName isEqualToString:@"Envelope"] && ![elementName isEqualToString:@"Body"])
	{
		[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
	}
}

- (NSString*) decodeString:(NSString*) string
{
	return [string xmlDecode];
}



@end
