//
//  FLJsonRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonRequest.h"
#import "_FLNetworkConnection.h"

@implementation FLJsonRequest

@synthesize jsonBuilder = _json;

- (id) init {
    self = [super init];
    if(self) {
    	_json = [[FLJsonBuilder alloc] init];
	}
    return self;
}

- (void) dealloc
{
	FLRelease(_json);
	FLSuperDealloc();
}

- (void) openNetworkStreams
{
    NSData* content = [[_json buildString] dataUsingEncoding:NSUTF8StringEncoding];
            
	[self.httpRequest setContentWithData:content typeContentHeader:@"application/json; charset=utf-8"]; 

	[super openNetworkStreams];
}

//- (NSString*) description
//{
//	return [NSString stringWithFormat:@"url:%@\npostHeader:%@\nsoapActionHeader:%@\napiNamespace:%@\nsoap:\n%@\n",
//		self.url,
//		[self postHeader],
//		_soapActionHeader,
//		_apiNamespace,
//		[_soap description]];
//}

@end
