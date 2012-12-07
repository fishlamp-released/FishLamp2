//
//	FLXmlParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"
#import "FLBaseXmlParser.h"
#import "FLObjectInflatorState.h"

#define FLXmlParserDomain @"FLXmlParserDomain"
typedef enum {
	FLXmlParserErrorCodeUnknownElement = 1
} FLXmlParserErrorCode;

@interface FLXmlParser : FLBaseXmlParser {
@private
    FLLinkedList* _parseState;
	NSData* _data;
	
    NSString* _fileName;
    BOOL _saveParsePositions;
	BOOL _gotFirstElement;
}

@property (readwrite, retain, nonatomic) NSString* fileName;

@property (readwrite, assign, nonatomic) BOOL saveParsePositions;

- (id) initWithXmlData:(NSData*) data;

+ (id) xmlParser:(NSData*) data;

- (void) buildObjects:(id) rootObject;

@end
