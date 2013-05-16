//
//  GtSoapRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 4/18/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtWebRequest.h"
#import "GtSoapBuilder.h"

@class GtSerializableObject;

@interface GtSoapRequest : GtWebRequest {
@private
	GtSoapBuilder* m_soap;
	NSString* m_apiNamespace;
	NSString* m_soapActionHeader;
}

@property (readwrite, assign, nonatomic) NSString* apiNamespace;
@property (readwrite, assign, nonatomic) NSString* soapActionHeader;
@property (readonly, assign, nonatomic) GtSoapBuilder* soapBuilder;

- (id) initWithSoapInfo:(NSString*) url
	postHeader:(NSString*) postHeader
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace;

- (void) addSoapParameter:(NSString*) name data:(NSString*) data;

- (void) addSoapParameters:(NSDictionary*) parameters;

- (void) addObjectAsFunction:(NSString*) functionName object:(GtSerializableObject*) object;

+ (NSString*) formatPostHeader:(NSString*) webServiceRelativeUrl;

@end


