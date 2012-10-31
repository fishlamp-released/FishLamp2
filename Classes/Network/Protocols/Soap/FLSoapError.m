//
//	FLSoapError.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLSoapError.h"

#define KEY @"fault"

@implementation NSError (FLSoapExtras) 

- (id) initWithSoapFault:(FLSoapFault11*) fault
{
	NSDictionary* userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
		fault, KEY, nil];

	if((self = [self initWithDomain:FLSoapFaultDomain
							   code:FLSoapFaultError
						   userInfo:userInfo]))
	{
	}
	
	FLReleaseWithNil_(userInfo); 
	
	return self;
}

- (BOOL) isSoapError
{
	return self.soapFault != nil;
}

- (FLSoapFault11*) soapFault
{
	return self.userInfo ? [self.userInfo objectForKey:KEY] : nil;
}


@end
