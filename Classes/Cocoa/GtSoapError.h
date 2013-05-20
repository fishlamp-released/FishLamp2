//
//	GtSoapError.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSoapFault11.h"

#define GtSoapFaultDomain @"GtSoapErrorDomain"
#define GtSoapFaultError -3000

@interface NSError (GtSoapExtras) 

- (id) initWithSoapFault:(GtSoapFault11*) fault;

- (BOOL) isSoapError;
- (GtSoapFault11*) soapFault;

@end
