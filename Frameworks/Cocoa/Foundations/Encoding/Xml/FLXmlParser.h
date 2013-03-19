//
//  FLXmlParser.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLParsedItem.h"

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
    
    FLParsedItem* _rootElement;
}

+ (id) xmlParser;

- (FLParsedItem*) parseFileAtPath:(NSString*) path;
- (FLParsedItem*) parseFileAtURL:(NSURL*) url;


- (FLParsedItem*) parseData:(NSData*) data;

// optional override
- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser;
@end
