//
//	GtSoapParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/11/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtXmlParser.h"

@interface GtSoapParser : GtXmlParser {
	struct {
		unsigned int foundBody: 1;
		unsigned int foundEnvelope: 1;
	} m_soapFlags;
}

+ (NSString*) stringWithDeletedNamespacePrefix:(NSString*) inStringWithNamespace; /* eg. 's:int' */
@end

