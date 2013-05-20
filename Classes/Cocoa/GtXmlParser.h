//
//	GtXmlParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtBaseXmlParser.h"
#import "GtObjectInflatorState.h"

#define GtXmlParserDomain @"GtXmlParserDomain"
typedef enum {
	GtXmlParserErrorCodeUnknownElement = 1
} GtXmlParserErrorCode;

@interface GtXmlParser : GtBaseXmlParser {
@private
	NSData* m_data;
	GtObjectInflatorState* m_parseState;
	
	struct {
		unsigned int gotFirstElement: 1;
	} m_xmlParserFlags;
}

- (id) initWithXmlData:(NSData*) data;

+ (GtXmlParser*) xmlParser:(NSData*) data;

- (void) buildObjects:(id) rootObject;

@end
