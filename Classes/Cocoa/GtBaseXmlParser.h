//
//	GtBaseXmlParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/6/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtDataParser.h"
#import "GtDataEncoder.h"

@interface GtBaseXmlParser : NSObject<GtDataParser, NSXMLParserDelegate> {
@private
   id<GtDataDecoder> m_dataDecoder;
   NSError* m_error;
   NSXMLParser* m_parser;
}

@property (readwrite, retain, nonatomic) NSError* error;
@property (readonly, retain, nonatomic) NSXMLParser* parser; // only valid during parse
@property (readwrite, retain, nonatomic) id<GtDataDecoder> dataDecoder;

- (void) parse:(NSData*) data;

- (void) onConfigureParser:(NSXMLParser*) parser;

@end
