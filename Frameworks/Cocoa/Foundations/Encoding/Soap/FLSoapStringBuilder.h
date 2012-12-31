//
//	FLSoapStringBuilder.h
//	FishLamp
//
//	Created By Mike Fullerton on 4/20/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"

#import "FLXmlStringBuilder.h"
#import "FLObjectXmlElement.h"

@interface FLSoapStringBuilder : FLXmlStringBuilder {
@private
    FLXmlElement* _envelopeElement;
    FLXmlElement* _bodyElement;
}

+ (id) soapStringBuilder;

@end

@interface FLObjectXmlElement (Soap)

+ (id) soapXmlElementWithObject:(id) object                 
                  xmlElementTag:(NSString*) functionName 
                   xmlNamespace:(NSString*) xmlNamespace;

- (void) addSoapParameter:(NSString*) name 
                    value:(NSString*) value;

- (void) addSoapParameters:(NSDictionary*) parameters;

@end

