//
//	FLSoapObjectBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
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

- (id) buildObjectWithType:(FLType*) type withSoap:(FLParsedItem*) element {
    FLAssertNotNil_(type);
    FLAssertNotNil_(element);

    NSDictionary* children = [element childrenAtPath:@"Envelope/Body"];

    FLConfirm_v(children.count == 1, @"Unable to parse object from SOAP");
    
    __unsafe_unretained id objects[1];
    __unsafe_unretained id keys[1];
    [children getObjects:objects andKeys:keys];
    
    return [self buildObjectWithType:type withXml:objects[0]];
}


@end