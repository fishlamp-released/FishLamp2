//
//	FLSoapStringBuilder.m
//	FishLamp
//
//	Created By Mike Fullerton on 4/20/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLSoapStringBuilder.h"
#import "FLSoapDataEncoder.h"
#import "NSObject+XML.h"
#import "FLXmlElement.h"

@implementation FLSoapStringBuilder

@synthesize body = _bodyElement;
@synthesize envelope = _envelopeElement;

- (id) init {
    self = [super init];
	if(self) {
		self.dataEncoder = [FLSoapDataEncoder instance];

		[self appendDefaultXmlDeclaration];
        _envelopeElement = [self addElement:@"soap:Envelope"];
        [_envelopeElement setAttribute:@"http://www.w3.org/2001/XMLSchema-instance"  forKey:@"xmlns:xsi"];
        [_envelopeElement setAttribute:@"http://www.w3.org/2001/XMLSchema" forKey:@"xmlns:xsd"];
		[_envelopeElement setAttribute:@"http://schemas.xmlsoap.org/soap/envelope/"forKey:@"xmlns:soap" ];

        _bodyElement = [self addElement:@"soap:Body"];
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_envelopeElement release];
    [_bodyElement release];
    [super dealloc];
}
#endif

@end

@implementation FLXmlElement (Soap)

- (NSString*) encodeString:(NSString*) string {
	return [string xmlEncode];
}

- (void) addObjectAsFunction:(NSString*) functionName 
                      object:(id) object                 
                xmlNamespace:(NSString*) xmlNamespace {

    FLXmlElement* element = [self addElement:functionName];
    [element setAttribute:xmlNamespace forKey:@"xmlns"];
    [element addObjectAsXML:object];
}

- (void) addSoapParameter:(NSString*) name value:(NSString*) value {
	[self addElement:name value:value];
}

- (void) addSoapParameters:(NSDictionary*) parameters {
	for(NSString* key in parameters) {
		[self addSoapParameter:key value:[parameters valueForKey:key]];
	}
}

@end