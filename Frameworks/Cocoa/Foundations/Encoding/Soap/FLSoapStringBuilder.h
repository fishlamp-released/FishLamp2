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
#import "FLXmlElement.h"

@interface FLSoapStringBuilder : FLXmlStringBuilder {
@private
    FLXmlElement* _envelopeElement;
    FLXmlElement* _bodyElement;
}

@property (readonly, strong, nonatomic) FLXmlElement* envelope;
@property (readonly, strong, nonatomic) FLXmlElement* body;

@end

@interface FLXmlElement (Soap)
- (void) addSoapParameter:(NSString*) name 
                    value:(NSString*) value;

- (void) addSoapParameters:(NSDictionary*) parameters;

- (void) addObjectAsFunction:(NSString*) functionName 
                      object:(id) object 
                xmlNamespace:(NSString*) xmlNamespace;

@end