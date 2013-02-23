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
    FLXmlParserValidationErrorHint
} FLXmlParserErrorHint;

@interface FLXmlObjectBuilder : NSObject<NSXMLParserDelegate, FLObjectBuilderDelegate> {
@private
    FLObjectBuilder* _objectBuilder;
    NSString* _fileName;
    BOOL _saveParsePositions;
	BOOL _gotFirstElement;
    NSXMLParser* _parser;
}

+ (id) xmlObjectBuilder;

@property (readwrite, retain, nonatomic) NSString* fileName;
@property (readwrite, assign, nonatomic) BOOL saveParsePositions;

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
