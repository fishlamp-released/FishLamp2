//
//	GtSoapBuilder.h
//	FishLamp
//
//	Created By Mike Fullerton on 4/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtXmlBuilder.h"

@interface GtSoapBuilder : GtXmlBuilder {
}

- (void) addSoapParameter:(NSString*) name data:(NSString*) data;

- (void) addSoapParameters:(NSDictionary*) parameters;

- (void) addObjectAsFunction:(NSString*) functionName object:(id) object namespace:(NSString*) namespace;

@end
