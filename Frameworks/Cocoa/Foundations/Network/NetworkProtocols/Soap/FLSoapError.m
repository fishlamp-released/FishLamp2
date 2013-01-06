//
//	FLSoapError.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLSoapError.h"
#import "FLFrameworkErrorDomain.h"

@implementation NSError (FLSoapExtras) 

- (id) initWithSoapFault:(FLSoapFault11*) fault
{
	NSDictionary* userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
		fault, FLUnderlyingSoapFaultKey, 
        [NSString stringWithFormat:@"%@:%@", fault.faultcode, fault.faultstring], NSLocalizedDescriptionKey, nil];

	if((self = [self initWithDomain:[FLFrameworkErrorDomain instance]
							   code:FLSoapFaultError
						   userInfo:userInfo]))
	{
	}
	
	FLReleaseWithNil(userInfo); 
	
	return self;
}

+ (id) errorWithSoapFault:(FLSoapFault11*) fault {
    return FLAutorelease([[[self class] alloc] initWithSoapFault:fault]);
}

- (FLSoapFault11*) soapFault {
	return self.userInfo ? [self.userInfo objectForKey:FLUnderlyingSoapFaultKey] : nil;
}


@end
