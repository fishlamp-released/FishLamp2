//
//	FLXmlObjectBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDataEncoder.h"
#import "FLObjectBuilder.h"

#define FLXmlParserDomain @"FLXmlParserDomain"

typedef enum {
	FLXmlParserErrorCodeUnknownElement = 1
} FLXmlParserErrorCode;

typedef enum {
    FLXmlParserParseErrorHint,
    FLXmlParserValidationErrorHint,
} FLXmlParserErrorHint;

typedef enum {
    FLXmlPropertyInflationIsAttribute = 1
} FLXmlPropertyInflation;


//@interface FLXmlObjectBuilder : NSObject<NSXMLParserDelegate, FLObjectBuilderDelegate> {
//@private
//    FLObjectBuilder* _objectBuilder;
//	BOOL _gotFirstElement;
//    NSXMLParser* _parser;
//}
//
//+ (id) xmlObjectBuilder;
//
//- (id) buildObjectWithClass:(Class) aClass 
//                     withData:(NSData*) data 
//              withDataDecoder:(id<FLDataDecoding>) decoder;
//
//// optional override
//- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser;
//
//@end
//
//@interface NSObject (FLXmlObjectBuilder)
//
//+ (id) objectWithContentsOfXMLFile:(NSString*) path 
//                   withDataDecoder:(id<FLDataDecoding>) decoder;
//
//@end


@interface FLXmlParser : NSObject<NSXMLParserDelegate> {
@private
    NSXMLParser* _parser;
    NSMutableArray* _stack;
    NSError* _error;
}

+ (id) xmlParser;

- (FLResultType(FLParsedXmlElement*)) parseData:(NSData*) data;

- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser;
@end

@interface FLParsedXmlElement : NSObject {
@private
    NSDictionary* _attributes;
    NSString* _namespace;
    NSString* _elementName;
    NSString* _qualifiedName;
    NSMutableString* _value;
    NSMutableDictionary* _elements;
    __unsafe_unretained FLParsedXmlElement* _parent;
}
+ (id) parsedXmlElement;

@property (readwrite, strong, nonatomic) NSDictionary* attributes;
@property (readwrite, strong, nonatomic) NSString* namespaceURI;
@property (readwrite, strong, nonatomic) NSString* elementName;
@property (readwrite, strong, nonatomic) NSString* qualifiedName;
@property (readonly, strong, nonatomic) NSString* value;
@property (readonly, strong, nonatomic) NSDictionary* elements;
@property (readonly, assign, nonatomic) FLParsedXmlElement* parent;

- (void) appendStringToValue:(NSString*) string;
- (void) addElement:(FLParsedXmlElement*) element;

- (FLParsedXmlElement*) elementAtPath:(NSString*) path;
- (FLParsedXmlElement*) elementForElementName:(NSString*) name;

- (id) inflateObjectWithType:(FLTypeDesc*) typeToInflate withDecoder:(id<FLDataDecoding>) decoder;

@end

@interface NSObject (FLXMLParsing) 
+ (id) objectWithXML:(FLParsedXmlElement*) xml withDecoder:(id<FLDataDecoding>) decoder;
@end
