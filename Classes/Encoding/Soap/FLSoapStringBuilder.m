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
        _envelopeElement = [[FLXmlElement alloc] initWithName:@"soap:Envelope"];
        [_envelopeElement setAttribute:@"http://www.w3.org/2001/XMLSchema-instance"  forKey:@"xmlns:xsi"];
        [_envelopeElement setAttribute:@"http://www.w3.org/2001/XMLSchema" forKey:@"xmlns:xsd"];
		[_envelopeElement setAttribute:@"http://schemas.xmlsoap.org/soap/envelope/"forKey:@"xmlns:soap" ];
        [self append:_envelopeElement];
        
        _bodyElement = [[FLXmlElement alloc] initWithName:@"soap:Body"];
        [_envelopeElement append:_bodyElement];
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

-(void) appendXmlVersionDeclaration:(NSString*) version 
               andEncodingHeader:(NSString*) encoding
               standalone:(BOOL) standalone {
    
    [self appendFormat:@"<?xml version=\"%@\" encoding=\"%@\"?>", version, encoding];
}

@end

@implementation FLXmlElement (Soap)

- (NSString*) encodeString:(NSString*) string {
	return [string xmlEncode];
}

- (void) addObjectAsFunction:(NSString*) functionName 
                      object:(id) object                 
                xmlNamespace:(NSString*) xmlNamespace {

    FLXmlElement* element = [FLXmlElement xmlElement:functionName];
    [element setAttribute:xmlNamespace forKey:@"xmlns"];
    [element addObjectAsXML:object];
    [self append:element];
}

- (void) addSoapParameter:(NSString*) name value:(NSString*) value {
    FLXmlElement* element = [FLXmlElement xmlElement:name];
    [element appendLine:value];
	[self append:element];
}

- (void) addSoapParameters:(NSDictionary*) parameters {
	for(NSString* key in parameters) {
		[self addSoapParameter:key value:[parameters valueForKey:key]];
	}
}

@end