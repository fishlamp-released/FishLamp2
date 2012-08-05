//
//	FLSoapNetworkConnection.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/18/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLHttpConnection.h"
#import "FLSoapBuilder.h"


@interface FLSoapNetworkConnection : FLHttpConnection {
@private
	FLSoapBuilder* _soap;
	NSString* _apiNamespace;
	NSString* _soapActionHeader;
}

@property (readwrite, retain, nonatomic) NSString* apiNamespace;
@property (readwrite, retain, nonatomic) NSString* soapActionHeader;
@property (readonly, retain, nonatomic) FLSoapBuilder* soapBuilder;

- (id) initWithURL:(NSURL*) url
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace;

+ (FLSoapNetworkConnection*) soapRequest:(NSURL*) url 
	soapActionHeader:(NSString*) soapActionHeader
	soapApiNamespace:(NSString*) apiNamespace;
	
@end

@interface FLHttpOperation (Soap)
- (NSString*) operationName; // returns nil by default.
@end


