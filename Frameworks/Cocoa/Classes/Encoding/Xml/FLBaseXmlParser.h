//
//	FLBaseXmlParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/6/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLDataParser.h"
#import "FLDataEncoder.h"

@interface FLBaseXmlParser : NSObject<FLDataParser, NSXMLParserDelegate> {
@private
   id<FLDataDecoder> _dataDecoder;
   NSError* _error;
   NSXMLParser* _parser;
}

@property (readonly, retain, nonatomic) NSError* error;
- (void) setError:(NSError*) error errorHint:(NSString*) errorHint;

@property (readonly, retain, nonatomic) NSXMLParser* parser; // only valid during parse
@property (readwrite, retain, nonatomic) id<FLDataDecoder> dataDecoder;

- (void) parse:(NSData*) data;

- (void) onConfigureParser:(NSXMLParser*) parser;
- (id<FLDataDecoder>) onCreateDataDecoder;

+ (NSString*) errorStringForCode:(NSXMLParserError) code;

@end
