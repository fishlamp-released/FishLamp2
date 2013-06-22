//
//  FLXmlParser.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLParsedXmlElement.h"

#define FLXmlParserDomain @"FLXmlParserDomain"

typedef enum {
	FLXmlParserErrorCodeUnknownElement = 1,
    FLXmlParserErrorCodeObjectNotFound
    
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
    
    FLParsedXmlElement* _rootElement;
    
    NSMutableDictionary* _prefixDictionary;
    NSMutableArray* _prefixStack;
}

+ (id) xmlParser;

- (FLParsedXmlElement*) parseFileAtPath:(NSString*) path;

- (FLParsedXmlElement*) parseFileAtURL:(NSURL*) url;

- (FLParsedXmlElement*) parseData:(NSData*) data;

// optional override
- (void) willParseXMLData:(NSData*) data 
            withXMLParser:(NSXMLParser*) parser;

+ (BOOL) canParseData:(NSData*) data;
@end
