//
//	GtSoapError.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSoapError.h"

#define KEY @"fault"

@implementation NSError (GtSoapExtras) 

- (id) initWithSoapFault:(GtSoapFault11*) fault
{
	NSDictionary* userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
		fault, KEY, nil];

	if((self = [self initWithDomain:GtSoapFaultDomain
							   code:GtSoapFaultError
						   userInfo:userInfo]))
	{
	}
	
	GtReleaseWithNil(userInfo); 
	
	return self;
}

- (BOOL) isSoapError
{
	return self.soapFault != nil;
}

- (GtSoapFault11*) soapFault
{
	return self.userInfo ? [self.userInfo objectForKey:KEY] : nil;
}


@end
