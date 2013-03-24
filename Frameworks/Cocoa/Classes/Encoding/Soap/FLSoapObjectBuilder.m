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

- (FLParsedItem*) willBuildObjectsWithXML:(FLParsedItem*) element {
    FLParsedItem* item = [element elementForElementName:@"Body"];
    return item ? item : element;
}

//- (NSArray*) objectsFromXML:(FLParsedItem*) xmlElement withObjectTypes:(NSArray*) properties {
//    FLAssertNotNil(xmlElement);
//    FLAssertNotNil(properties);
//    
//    FLParsedItem* body = [xmlElement elementAtPath:@"Body/"];
//    if(body) {
//        return [super objectsFromXML:body withObjectTypes:properties];
//    }
//
//    return [super objectsFromXML:xmlElement withObjectTypes:properties];
//}
//



@end