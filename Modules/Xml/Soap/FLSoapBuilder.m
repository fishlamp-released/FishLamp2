//
//	FLSoapBuilder.m
//	FishLamp
//
//	Created By Mike Fullerton on 4/20/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLSoapBuilder.h"
#import "FLSoapDataEncoder.h"
#import "NSObject+XML.h"

@implementation FLSoapBuilder

- (id) init {
    self = [super init];
	if(self) {
		self.dataEncoder = [FLSoapDataEncoder instance];

		[self appendDefaultXmlDeclaration];
		
		// TODO: Not sure if these attributes are okay to be hardcoded? Prob not.
		[self pushAttribute:@"xmlns:xsi" value:@"http://www.w3.org/2001/XMLSchema-instance" ];
		[self pushAttribute:@"xmlns:xsd" value:@"http://www.w3.org/2001/XMLSchema"];
		[self pushAttribute:@"xmlns:soap" value:@"http://schemas.xmlsoap.org/soap/envelope/"];
		[self openElement:@"soap:Envelope"];
		[self openElement:@"soap:Body"];
	}
	return self;
}

- (NSString*) buildString {
	[self closeElement]; // Body
	[self closeElement]; // Envelope
	
	return [super buildString];
}

- (NSString*) encodeString:(NSString*) string {
	return [string xmlEncode];
}

- (void) addObjectAsFunction:(NSString*) functionName 
                      object:(id) object                 
                xmlNamespace:(NSString*) xmlNamespace {

	[self pushAttribute:@"xmlns" value:xmlNamespace];
	[self openElement:functionName];
	[self addObjectAsXML:object];
	[self closeElement];
}

- (void) addSoapParameter:(NSString*) name value:(NSString*) value {
	[self appendElement:name value:value];
}

- (void) addSoapParameters:(NSDictionary*) parameters {
	for(NSString* key in parameters) {
		[self addSoapParameter:key value:[parameters valueForKey:key]];
	}
}


@end
