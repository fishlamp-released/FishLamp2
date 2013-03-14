//
//	FLSoapObjectBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLXmlObjectBuilder.h"

@interface FLSoapObjectBuilder : FLXmlObjectBuilder {
}

FLSingletonProperty(FLSoapObjectBuilder);


// this removes envelope/body elements before trying to build object
// if already removed call buildObjectWithClass:withXml:
- (id) buildObjectWithClass:(Class) aClass withSoap:(FLParsedXmlElement*) element;

@end



