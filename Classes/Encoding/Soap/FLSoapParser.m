//
//	FLSoapParser.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLSoapParser.h"
#import "NSString+XML.h"
#import "FLSoapDataEncoder.h"

@implementation FLSoapParser

+ (NSString*) stringWithDeletedNamespacePrefix:(NSString*) elementName {
	NSRange prefix = [elementName rangeOfString:@":"];
	return prefix.length > 0 ? [elementName substringFromIndex:prefix.location+1] : elementName;
}

- (id<FLDataDecoder>) onCreateDataDecoder {
    return [FLSoapDataEncoder instance];
}

- (void) onConfigureParser:(NSXMLParser*) parser {
	[parser setShouldProcessNamespaces:YES];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
	attributes:(NSDictionary *)attributeDict {

	if(!_soapFlags.foundEnvelope && [elementName isEqualToString:@"Envelope"]) {
		_soapFlags.foundEnvelope = YES;
	}
	else if(!_soapFlags.foundBody && [elementName isEqualToString:@"Body"]) {
		_soapFlags.foundBody = YES;
	}
	else {
		[super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
	}
}
- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName {

	if(![elementName isEqualToString:@"Envelope"] && ![elementName isEqualToString:@"Body"]) {
		[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
	}
}

- (NSString*) decodeString:(NSString*) string {
	return [string xmlDecode];
}

+ (id) soapParser:(NSData*) data {
    return [self xmlParser:data];
}

@end
