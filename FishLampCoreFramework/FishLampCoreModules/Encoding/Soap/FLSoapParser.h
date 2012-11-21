//
//	FLSoapParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLXmlParser.h"

@interface FLSoapParser : FLXmlParser {
	struct {
		unsigned int foundBody: 1;
		unsigned int foundEnvelope: 1;
	} _soapFlags;
}

+ (id) soapParser:(NSData*) data;

+ (NSString*) stringWithDeletedNamespacePrefix:(NSString*) inStringWithNamespace; /* eg. 's:int' */
@end

