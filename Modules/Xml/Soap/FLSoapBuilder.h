//
//	FLSoapBuilder.h
//	FishLamp
//
//	Created By Mike Fullerton on 4/20/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLXmlBuilder.h"

@interface FLSoapBuilder : FLXmlBuilder {
}

- (void) addSoapParameter:(NSString*) name 
                    value:(NSString*) value;

- (void) addSoapParameters:(NSDictionary*) parameters;

- (void) addObjectAsFunction:(NSString*) functionName 
                      object:(id) object 
                xmlNamespace:(NSString*) xmlNamespace;

@end
