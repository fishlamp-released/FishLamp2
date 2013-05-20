//
//	GtSoapNetworkConnection.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/18/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtHttpOperation.h"
#import "GtHttpConnection.h"
#import "GtSoapBuilder.h"


@interface GtSoapNetworkConnection : GtHttpConnection {
@private
	GtSoapBuilder* m_soap;
	NSString* m_apiNamespace;
	NSString* m_soapActionHeader;
}

@property (readwrite, retain, nonatomic) NSString* apiNamespace;
@property (readwrite, retain, nonatomic) NSString* soapActionHeader;
@property (readonly, retain, nonatomic) GtSoapBuilder* soapBuilder;

- (id) initWithURL:(NSURL*) url
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace;

+ (GtSoapNetworkConnection*) soapRequest:(NSURL*) url 
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace;
	
@end

@interface GtHttpOperation (Soap)
- (NSString*) operationName; // returns nil by default.
@end


