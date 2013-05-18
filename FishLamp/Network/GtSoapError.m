//
//  GtSoapError.m
//  MyZen
//
//  Created by Mike Fullerton on 12/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSoapError.h"

#define KEY @"fault"

@implementation NSError (GtSoapExtras) 

- (id) initWithSoapFault:(GtSoapFault11*) fault
{
	NSDictionary* userInfo = [GtAlloc(NSDictionary) initWithObjectsAndKeys:
        fault, KEY, nil];

	if(self = [self initWithDomain:GtSoapFaultDomain
                               code:gtErr_SoapFault
                           userInfo:userInfo])
    {
    }
    
    GtRelease(userInfo); 
	
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
