//
//	FLSoapObjectBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/11/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSoapObjectBuilder.h"
#import "NSString+XML.h"
#import "FLSoapDataEncoder.h"

//@implementation FLSoapObjectBuilder
//
//+ (id) soapObjectBuilder {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//+ (NSString*) stringWithDeletedNamespacePrefix:(NSString*) elementName {
//	NSRange prefix = [elementName rangeOfString:@":"];
//	return prefix.length > 0 ? [elementName substringFromIndex:prefix.location+1] : elementName;
//}
//
//- (id<FLDataDecoding>) onCreateDataDecoder {
//    return [FLSoapDataEncoder instance];
//}
//
//- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser {
//	[parser setShouldProcessNamespaces:YES];
//	[parser setShouldReportNamespacePrefixes:NO];
//	[parser setShouldResolveExternalEntities:NO];
//}
//
//- (void)parser:(NSXMLParser *)parser 
//didStartElement:(NSString *)elementName 
//  namespaceURI:(NSString *)namespaceURI 
// qualifiedName:(NSString *)qName 
//	attributes:(NSDictionary *)attributeDict {
//
//	if(!_soapFlags.foundEnvelope && [elementName isEqualToString:@"Envelope"]) {
//		_soapFlags.foundEnvelope = YES;
//	}
//	else if(!_soapFlags.foundBody && [elementName isEqualToString:@"Body"]) {
//		_soapFlags.foundBody = YES;
//	}
//	else {
//		[super parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
//	}
//}
//- (void)parser:(NSXMLParser *)parser 
// didEndElement:(NSString *)elementName 
//  namespaceURI:(NSString *)namespaceURI 
// qualifiedName:(NSString *)qName {
//
//	if(![elementName isEqualToString:@"Envelope"] && ![elementName isEqualToString:@"Body"]) {
//		[super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
//	}
//}
//
//@end


@implementation FLSoapObjectBuilder 

FLSynthesizeSingleton(FLSoapObjectBuilder);

- (id) init {
    self = [super initWithDataDecoder:[FLSoapDataEncoder instance]];
    if(self) {
    }
    return self;
}

//- (FLParsedXmlElement*) findElementForBuilding:(NSString*) objectName 
//                               inParentElement:(FLParsedXmlElement*) parentElement  {
//
//    FLParsedXmlElement* newParent = [parentElement childElementForName:@"Body"];
//
//    return [super findElementForBuilding:objectName inParentElement:(newParent != nil ? newParent : parentElement)];
//}

@end