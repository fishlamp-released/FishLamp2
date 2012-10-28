//
//	FLSoapError.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "FLSoapFault11.h"

#define FLSoapFaultDomain @"FLSoapErrorDomain"
#define FLSoapFaultError -3000

@interface NSError (FLSoapExtras) 

- (id) initWithSoapFault:(FLSoapFault11*) fault;

- (BOOL) isSoapError;
- (FLSoapFault11*) soapFault;

@end
