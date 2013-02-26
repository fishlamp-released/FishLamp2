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

@interface FLXmlObjectBuilder : NSObject<NSXMLParserDelegate, FLObjectBuilderDelegate> {
@private
    FLObjectBuilder* _objectBuilder;
	BOOL _gotFirstElement;
    NSXMLParser* _parser;
}

+ (id) xmlObjectBuilder;

- (id) buildObjectWithClass:(Class) aClass 
                     withData:(NSData*) data 
              withDataDecoder:(id<FLDataDecoding>) decoder;

// optional override
- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser;

@end

@interface NSObject (FLXmlObjectBuilder)

+ (id) objectWithContentsOfXMLFile:(NSString*) path 
                   withDataDecoder:(id<FLDataDecoding>) decoder;

@end


@interface FLXmlParser : NSObject<NSXMLParserDelegate> {
@private
	BOOL _gotFirstElement;
    NSXMLParser* _parser;
    NSMutableArray* _stack;
    NSError* _error;
}

+ (id) xmlParser;

- (FLResult) parseData:(NSData*) data;

- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser;

//- (id) buildObjectWithDictionary:(NSDictionary*) dictionary
//                        forClass:(Class) aClass 
//                     withDecoder:(id<FLDataDecoding>) decoder;

@end

@interface NSDictionary (FLXmlParsing)
- (id) objectAtPath:(NSString*) path; // e.g. @"Envelope/Body/Foo"
@end


