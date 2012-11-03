//
//  FLJsonRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonRequest.h"
#import "FLNetworkConnection_Internal.h"
#import "FLJsonStringBuilder.h"

@implementation FLJsonRequest

@synthesize json = _json;

- (id) init {
    self = [super init];
    if(self) {
    	_json = [FLJsonStringBuilder stringBuilder];
	}
    return self;
}

- (void) dealloc
{
	mrc_release_(_json);
	super_dealloc_();
}

- (void) startWorking:(id<FLFinisher>) finisher {
    NSData* content = [[_json buildStringWithNoWhitespace] dataUsingEncoding:NSUTF8StringEncoding];
	[self.httpRequest setContentWithData:content typeContentHeader:@"application/json; charset=utf-8"];
	[super startWorking:finisher];
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
