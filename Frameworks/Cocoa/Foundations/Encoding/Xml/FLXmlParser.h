//
//  FLXmlParser.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLParsedXmlElement.h"

#define FLXmlParserDomain @"FLXmlParserDomain"

typedef enum {
	FLXmlParserErrorCodeUnknownElement = 1
} FLXmlParserErrorCode;

typedef enum {
    FLXmlParserParseErrorHint,
    FLXmlParserValidationErrorHint,
} FLXmlParserErrorHint;


@interface FLXmlParser : NSObject<NSXMLParserDelegate> {
@private
    NSXMLParser* _parser;
    NSMutableArray* _stack;
    NSError* _error;
}

+ (id) xmlParser;

- (FLParsedXmlElement*) parseData:(NSData*) data;

// optional override
- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser;
@end
