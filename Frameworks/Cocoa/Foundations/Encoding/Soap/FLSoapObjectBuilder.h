//
//	FLSoapObjectBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#import "FLXmlObjectBuilder.h"

@interface FLSoapObjectBuilder : FLXmlObjectBuilder {
	struct {
		unsigned int foundBody: 1;
		unsigned int foundEnvelope: 1;
	} _soapFlags;
}

+ (id) soapObjectBuilder;

+ (NSString*) stringWithDeletedNamespacePrefix:(NSString*) inStringWithNamespace; /* eg. 's:int' */
@end
