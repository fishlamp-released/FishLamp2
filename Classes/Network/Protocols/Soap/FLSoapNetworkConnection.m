////
////	FLSoapNetworkConnection.m
////	FishLamp
////
////	Created by Mike Fullerton on 4/18/09.
////	Copyright 2009 Greentongue Software. All rights reserved.
////
//
//#import "FLSoapNetworkConnection.h"
//#import "FLNetworkConnection_Internal.h"
//
//@implementation FLSoapNetworkConnection
//
//@synthesize apiNamespace = _apiNamespace;
//@synthesize soapActionHeader = _soapActionHeader;
//@synthesize soap = _soap;
//
//- (id) initWithURL:(NSURL*) url
//	soapActionHeader:(NSString*) soapActionHeader
//	soapApiNamespace:(NSString*) apiNamespace {
//	FLAssertStringIsNotEmpty_v(soapActionHeader, nil);
//	FLAssertStringIsNotEmpty_v(apiNamespace, nil);
//	
//	if((self = [super initWithHttpRequest:[FLHttpRequest httpRequestWithURL:url requestMethod:@"POST"]])) {
//		self.apiNamespace = apiNamespace;
//		self.soapActionHeader = soapActionHeader;
//		_soap = [FLSoapStringBuilder stringBuilder];
//	}
//	return self;
//}
//
//- (void) dealloc {
//	release_(_apiNamespace);
//	release_(_soapActionHeader);
//	release_(_soap);
//	super_dealloc_();
//}
//
//- (FLFinisher*) startWorking:(FLFinisher*) finisher {
//    [super startWorking:finisher];
//}
//
//- (NSString*) description {
//	return [NSString stringWithFormat:@"url:%@\npostHeader:%@\nsoapActionHeader:%@\napiNamespace:%@\nsoap:\n%@\n",
//		self.httpRequest.requestURL,
//		self.httpRequest.postHeader,
//		_soapActionHeader,
//		_apiNamespace,
//		[_soap description]];
//}
//
//+ (FLSoapNetworkConnection*) soapRequest:(NSURL*) url 
//	soapActionHeader:(NSString*) soapActionHeader
//	soapApiNamespace:(NSString*) apiNamespace {
//	return autorelease_([[FLSoapNetworkConnection alloc] initWithURL:url soapActionHeader:soapActionHeader soapApiNamespace:apiNamespace]);
//}
//
//@end
//
//@implementation FLHttpOperation (Soap)
//
//- (NSString*) operationName {
//	return nil;
//}
//
//@end
//
