//
//  GtJsonRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtJsonRequest.h"


@implementation GtJsonRequest

- (GtJsonBuilder*) json
{
	if(!m_json)
	{
		m_json = [[GtJsonBuilder alloc] init];
	}
	
	return m_json;
}

- (void) dealloc
{
	GtRelease(m_json);
	GtSuperDealloc();
}

- (void) prepareRequest
{
	NSData* content = [(m_json ? [m_json buildString] : @"") dataUsingEncoding:NSUTF8StringEncoding];
	[self.httpRequest setContentWithData:content typeContentHeader:@"application/json; charset=utf-8"]; 
	[super prepareRequest];
}

//- (NSString*) description
//{
//	return [NSString stringWithFormat:@"url:%@\npostHeader:%@\nsoapActionHeader:%@\napiNamespace:%@\nsoap:\n%@\n",
//		self.url,
//		[self postHeader],
//		m_soapActionHeader,
//		m_apiNamespace,
//		[m_soap description]];
//}



@end
